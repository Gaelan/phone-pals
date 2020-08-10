class TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_after_action :verify_authorized
  before_action :validate_request

  def incoming
    respond do |r|
      r.gather(
        action: twilio_got_code_url, num_digits: 6, action_on_empty_result: true
      ) do |g|
        g.say message:
                'Welcome to Phone Pals! Please enter the 6-digit code you see on the website.'
      end
    end
  end

  def got_code
    code = params['Digits']
    if code.empty?
      respond do |r|
        r.gather(
          action: twilio_got_code_url,
          num_digits: 6,
          action_on_empty_result: true
        ) do |g|
          g.say message:
                  "Sorry, I didn't get a code from you. Please try again."
        end
      end
      return
    end

    if code.length != 6
      respond do |r|
        r.gather(
          action: twilio_got_code_url,
          num_digits: 6,
          action_on_empty_result: true
        ) do |g|
          g.say message:
                  "Sorry, I didn't get all six digits of the code. Please try again."
        end
      end
      return
    end

    relationship = Relationship.find_by_code(code)

    unless relationship
      respond do |r|
        r.gather(
          action: twilio_got_code_url,
          num_digits: 6,
          action_on_empty_result: true
        ) do |g|
          g.say message: "Sorry, that's not a valid code. Please try again."
        end
      end
      return
    end

    call =
      Call.create(
        callee: relationship.callee,
        user: relationship.user,
        incoming_number: params['From']
      )

    respond do |r|
      r.dial(
        number: relationship.callee.e164_number,
        caller_id: Phonelib.parse(ENV['TWILIO_NUMBER']).e164,
        action: twilio_post_call_url(call_id: call.id)
      )
    end
  end

  def post_call
    Call.find(params[:call_id]).update(
      complete: true, seconds: params['DialCallDuration']
    )

    respond(&:hangup)
  end

  protected

  def respond(&block)
    response = Twilio::TwiML::VoiceResponse.new(&block)

    render xml: response.to_s
  end

  def validate_request
    validator = Twilio::Security::RequestValidator.new(ENV['TWILIO_AUTH_TOKEN'])

    p request.original_url,
      request.request_parameters,
      request.headers['X-Twilio-Signature']
    unless validator.validate(
             request.original_url,
             request.request_parameters,
             request.headers['X-Twilio-Signature']
           )
      render status: :unauthorized, plain: 'Twilio auth failed.'
    end
  end
end
