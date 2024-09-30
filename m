Return-Path: <linux-hyperv+bounces-3090-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D87AB989C6F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 10:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA78281CB0
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Sep 2024 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CAB165F1E;
	Mon, 30 Sep 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UjjJBfSe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA34204B
	for <linux-hyperv@vger.kernel.org>; Mon, 30 Sep 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727684219; cv=none; b=sldjX+pmazWNPLjHiZcwhSN81MdRQCLVRFPAX8hEpoeC3TxO3b5+w5GboW5oKzgoMrSaWvXDsTlzh9oENWxcimYJvCatVq1UC02rTLtoH2AQ7CPFeuOF5f7NCN7t05WQ8yntpP0ukNqL/dNS+JGqlT+WR0BZxejX6Xa7lCyqWFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727684219; c=relaxed/simple;
	bh=T3CjOlRKqo+zYWNYjyx8LHGdyPySLyzXu+jLftjzfi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtvzeOywMoGFxqwLyeulm3b+Ps1zAS48zJqxwn4ck79l4P8VfDKRIcMfBovEKY+zqLyTGbpN0tk1B7PXRfUcrqFU/mPRLz0Qwa/QPzHFk2m1C2xZgF7cmOO96jDkR5G813wCf53ezbvMsOlXQYPyBAzsf6ngGQLkNgHflPl4AI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UjjJBfSe; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso2997156a91.0
        for <linux-hyperv@vger.kernel.org>; Mon, 30 Sep 2024 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1727684217; x=1728289017; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XuaDxlsCRRTkMoK88CV+WrpMskzIy1cBHghumDaXOwU=;
        b=UjjJBfSeCIy1ussQxlzL9Oe3m2a+H+NmUH2bwpIBfUiJ3t5lEuMRHx1gIbax25rfbG
         40qw3ZMdiA4MK7IXv4veBd9qcsFi2GMUVrH12JBGOMsYxy+WbvvWB2idhQAO9+sjqLjC
         qEpxMGf/LNsljVRlAnZ3hCttzBAMX3V9C1BWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727684217; x=1728289017;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XuaDxlsCRRTkMoK88CV+WrpMskzIy1cBHghumDaXOwU=;
        b=eGFlPgvlkcGm+KhxmN4BE4U7BGk4W35pAw+/NhGP6nikYa5SUa/zewOfZm2hgeriZF
         brJQvCsXyqdllPwtosQUzdPm5JHRuh2uLkuVdar08Yy5C3RVeUbYymBQKgp9RyNYkeXy
         snbUz/AYd0bACNQ4yPQsTJ48irMlTTYNJrmF3stG1imtlyUR/c8xaF8k5Eb2mroaSmLA
         VM5GitVqWmnlCNPBuW6/rvcVR8RckuhBZGXkh8mL9/gwBlpnB9y6BxEb46fkQfhjItlU
         B8DpjX2PtlrMGo0SC0BsOOngIHtUugkW7UFZgt+M5pVTPu+9lQRmvGnzvpfcSKzabQj3
         FBYw==
X-Gm-Message-State: AOJu0YwlIK8Bx3RG02uMNA6zU1pt5SkO0/PHJJrK3pZY3C8r794hPKI7
	O5A3EPNy0zpM5ngy5cbImrbfBW9kTF1dyWZaE/lRiHW/SCQmV2KbcuxNfPcV2KPO2fNG9BqlOsY
	tRgBTPkPJ2reYYtzfRH4x1zL7Jop7ab6HVUth
X-Google-Smtp-Source: AGHT+IHNMzSmCdD3VPOdcz482zoFVww7dbes5TEsCEi5MWLVMwG2b9u7aU4e3LYYRwfdytM1ljogLnNL3Z/Tqj9v+iw=
X-Received: by 2002:a17:90a:ad8e:b0:2e0:944b:9524 with SMTP id
 98e67ed59e1d1-2e0b8b19d3amr13282945a91.22.1727684216710; Mon, 30 Sep 2024
 01:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1727667875-29908-1-git-send-email-shradhagupta@linux.microsoft.com>
In-Reply-To: <1727667875-29908-1-git-send-email-shradhagupta@linux.microsoft.com>
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
Date: Mon, 30 Sep 2024 13:46:44 +0530
Message-ID: <CALs4sv31-ZT1j5y+f=SaCrW54w2UYZ1RzEm1ncAeSRjZFdnUsQ@mail.gmail.com>
Subject: Re: [PATCH net-next RESEND] net: mana: Increase the
 DEF_RX_BUFFERS_PER_QUEUE to 1024
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Long Li <longli@microsoft.com>, Simon Horman <horms@kernel.org>, 
	Konstantin Taranov <kotaranov@microsoft.com>, 
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, Erick Archer <erick.archer@outlook.com>, 
	Ahmed Zaki <ahmed.zaki@intel.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Shradha Gupta <shradhagupta@microsoft.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000000d9896062351d465"

--0000000000000d9896062351d465
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 9:14=E2=80=AFAM Shradha Gupta
<shradhagupta@linux.microsoft.com> wrote:
>
> Through some experiments, we found out that increasing the default
> RX buffers count from 512 to 1024, gives slightly better throughput
> and significantly reduces the no_wqe_rx errs on the receiver side.
> Along with these, other parameters like cpu usage, retrans seg etc
> also show some improvement with 1024 value.
>
> Following are some snippets from the experiments
>
> ntttcp tests with 512 Rx buffers
> ---------------------------------------
> connections|  throughput|  no_wqe errs|
> ---------------------------------------
> 1          |  40.93Gbps | 123,211     |
> 16         | 180.15Gbps | 190,120     |
> 128        | 180.20Gbps | 173,508     |
> 256        | 180.27Gbps | 189,884     |
>
> ntttcp tests with 1024 Rx buffers
> ---------------------------------------
> connections|  throughput|  no_wqe errs|
> ---------------------------------------
> 1          |  44.22Gbps | 19,864      |
> 16         | 180.19Gbps | 4,430       |
> 128        | 180.21Gbps | 2,560       |
> 256        | 180.29Gbps | 1,529       |
>
> So, increasing the default RX buffers per queue count to 1024
>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
> ---
>  include/net/mana/mana.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Looks good to me.
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

--0000000000000d9896062351d465
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
OltyqaGBuzv+bJTUL+bmV7E4QBLIqGt4jVr1R9hJdH6KxXwJdyfHZ9C6qXmoe2NQhiFUyBOJ0wgk
dB9Z1IU7nCwvNKYg2JMoJs93tIgbhPJg/D7pqW8gabkCAwEAAaOCAdowggHWMA4GA1UdDwEB/wQE
AwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUHMAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFs
c2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNydDBBBggrBgEFBQcw
AYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAw
TQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2Jh
bHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDov
L2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcmwwJAYDVR0R
BB0wG4EZcGF2YW4uY2hlYmJpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUEV6y/89alKPoFbKUaJXsvWu5
fdowDQYJKoZIhvcNAQELBQADggEBAEHSIB6g652wVb+r2YCmfHW47Jo+5TuCBD99Hla8PYhaWGkd
9HIyD3NPhb6Vb6vtMWJW4MFGQF42xYRrAS4LZj072DuMotr79rI09pbOiWg0FlRRFt6R9vgUgebu
pWSH7kmwVXcPtY94XSMMak4b7RSKig2mKbHDpD4bC7eGlwl5RxzYkgrHtMNRmHmQor5Nvqe52cFJ
25Azqtwvjt5nbrEd81iBmboNTEnLaKuxbbCtLaMEP8xKeDjAKnNOqHUMps0AsQT8c0EGq39YHpjp
Wn1l67VU0rMShbEFsiUf9WYgE677oinpdm0t2mdCjxr35tryxptoTZXKHDxr/Yy6l6ExggJtMIIC
aQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQD
EyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwV/XkICjVscn4SNZMw
DQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOV4rNVZKWTzkJrDhqy5ooCInaN7w/c7
NTdFg+cFW7WvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI0MDkz
MDA4MTY1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQC
ATANBgkqhkiG9w0BAQEFAASCAQAXgCHdHAYQfr4n2g6L7gIelGZykGoziYXWFx0TUKQCV4Sb4gb+
dsOAeZZ47B8gMhDfnbnJ+JzynE7UV2McxMouMq5vYqoxd3Y7ndW9RoVsLFp4xJJNRXPz/LzKrOcm
NK3QCsk0lKuDQF/cB0aMquXstf7lEAM+qPYdmyzugF1pMP+qGn/hPKQ6PPCyqyBPFNRYKjTrZ/Vi
/PSittF1InqBOlGDHi72qz7zCvdgCHFXGpz9vG0X8ioqrq+7VDiZsTlmvaClMk1IRKSoDFlxu7yJ
jt4WFZR6OY8EyQ6ExzOZmV1CXhBUYpElkEkHJbPET71rQBqHYyoZhtKljs3iFG+R
--0000000000000d9896062351d465--

