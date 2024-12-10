Return-Path: <linux-hyperv+bounces-3452-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5B69EAA45
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 09:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8C92820C3
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2024 08:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4CDA22A1D5;
	Tue, 10 Dec 2024 08:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dUOTG0G4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCC0194C6A
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Dec 2024 08:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818076; cv=none; b=OlOokFumoTAMi+gZwHVJvy0Vag7dMjuY5kIrnwhTFPbOLd8T8IOgvYS2vakCzSYezqkf6FY9jzik/F9/kuG5fbbTPoz4hJ/dkVtOGkAIsidnQ0rw1LieBSiOsfB4zoAaOm6cfI4Z6ik01s90ND2lnM/+ygHYlrr4a+3A95d5aWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818076; c=relaxed/simple;
	bh=z6S2mHmsZMC2cxML5OVpEyiNZNzxSnRj5YKZySsDetQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kxOT9OhokGKHWWc0L0Iua/zPHAqHymeYX6/339k7o8arnoRkENe39dJYbgIbWYVQjO/j57JHnmAF2LnFPq2c5t9zZt0xj4fbHBEquEF7H2/1+/FHLVUVOmzUGBfANGw2XO8wechGZ/dzXX32PY0mRuyglkOzWO4zBbIMd1ojGo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dUOTG0G4; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5401c52000dso2121155e87.3
        for <linux-hyperv@vger.kernel.org>; Tue, 10 Dec 2024 00:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733818073; x=1734422873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z6S2mHmsZMC2cxML5OVpEyiNZNzxSnRj5YKZySsDetQ=;
        b=dUOTG0G4TgBx7eMLtRa5LHAZmLm/X/+6qde4CNm1j271k5LS+IxYCYXqOARfFXKxJD
         N1YAXtTowF2o1460CH4Q5+rsHLWHU7WJSW3R/G1EJi/riF1tG5f2PRfslZYZWc6DSGgW
         2QQGGhyohShA39uLPNC/7BR4XWgdPyx4R1NuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733818073; x=1734422873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6S2mHmsZMC2cxML5OVpEyiNZNzxSnRj5YKZySsDetQ=;
        b=vIgrRXNPqmCvj9dL0q85lkNqKiGeCy8MHHSF5LqDwVY2r9Vyne5vjNGmwlINn8SKuC
         etsQlKl5NTOjCJ0p1vGSQr5odRgbcp7jPL2DTgPzbKPNcuYvfb5A5hLnxa2DJSOnmEZ3
         lqtAIi8f6/TIXcizxbwVfFYKpJfh4X5zAEmFuwQepOEDdZcKwqZ0ykR7BJYAAKCajds3
         /2LKy28cZXjcu5n9l/3M0wzKjXaQswmFgZE4ji9pn5mKFyiE+lFrE0fWHt6TemEWUlHa
         pPPyaBdwSKHfhDnvg7YpsZLVFHF6JVry2Gf0C3VGnIWo4Wdw3Yk25B5tjnCCWIm1vNxK
         z57g==
X-Forwarded-Encrypted: i=1; AJvYcCVG9jzgbIyZmk6SgdxIw7fcggWPdfCgCfAZjFFd++8HllRowjgIizL2X6tM6MThZsXU+EgoE+J6nQ/0Oqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK2SWFmvBuiXiFlhrkx2TR/v6ejg9SY2qDRE/dZddFujEJCk/u
	Lm/IkD6u5DW4n+zXyEVHf7SZCBsfy57l8YuMFJhxKP2+MwQDg213xl1bdkMrgQZH4maRHmouGFS
	GgmdXP+U2mvA6rSJ4TjMnjT1HeSMruKOCbWsb
X-Gm-Gg: ASbGncubhWJNSuaHEGUp+Ka2ZVF4+t687dJgIUxxTRKY2M1O6T2b7hXleaDlj9rXkox
	WAPP3whsiDev7BsAoCobO0dKJHb5A62SvHmEH
X-Google-Smtp-Source: AGHT+IFUM00bXrbZPM88kU9gRNDUuamgsxOoWDbEMA49d+kpeyOs51eCsZxCwHrC4xexdtUL809J0fzCQ6i9JAtHGk0=
X-Received: by 2002:a05:6512:23a1:b0:53e:391c:e983 with SMTP id
 2adb3069b0e04-53e391cec2fmr5383699e87.3.1733818073241; Tue, 10 Dec 2024
 00:07:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209175751.287738-1-mlevitsk@redhat.com> <20241209175751.287738-3-mlevitsk@redhat.com>
In-Reply-To: <20241209175751.287738-3-mlevitsk@redhat.com>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Tue, 10 Dec 2024 13:37:43 +0530
Message-ID: <CAH-L+nM8v2paYtRoNpcRtFFsiWyuUGBE8r85fDNMpaXcJo=7_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] net: mana: Fix irq_contexts memory leak in mana_gd_setup_irqs
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Haiyang Zhang <haiyangz@microsoft.com>, 
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, linux-hyperv@vger.kernel.org, 
	Dexuan Cui <decui@microsoft.com>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Konstantin Taranov <kotaranov@microsoft.com>, Leon Romanovsky <leon@kernel.org>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Long Li <longli@microsoft.com>, 
	Yury Norov <yury.norov@gmail.com>, Michael Kelley <mhklinux@outlook.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000061dca50628e5fa15"

--00000000000061dca50628e5fa15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 11:29=E2=80=AFPM Maxim Levitsky <mlevitsk@redhat.com=
> wrote:
>
> gc->irq_contexts is not freeded if one of the later operations
> fail.
>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Fixes: 8afefc361209 ("net: mana: Assigning IRQ affinity on HT cores")
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

LGTM
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>


--=20
Regards,
Kalesh A P

--00000000000061dca50628e5fa15
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEINdZoc3reemdznR8PIrnCdocsWW1cXx5XnQB3qvKKqbIMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MTIxMDA4MDc1M1owaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBzFBzQGh8c
XN42bCiVN7kMjngXqDfNZ3moAZI0OnXYUWYMUOlwCX+2O76iM+lyHGV7g8p5u1gaeNFVfeVPCspL
aVqWtHzl69dHxHVBMi0h5rxL4JFvORX9Mk/idniUADzuRYZFDgXsU7Z4qASAPQrZ85nNSUJxLaBJ
6zB9YpA8pkcjEyBmLhDayom/rMJUATTee4MromOH28mzWlS59xWw3qwaasZ8N0zEeplqFyGfjSqW
pWGeoEzmARaf5MKbNS01k1RL8jL5iGcipYOByAhs3NTKip74mJ5IzyrdvNnQJunuKJXxTSEvBvHD
ICq2t+Rh/OwKjNV8ZR4aZ4OvMG4C
--00000000000061dca50628e5fa15--

