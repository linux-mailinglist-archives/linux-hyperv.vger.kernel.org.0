Return-Path: <linux-hyperv+bounces-5895-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BDEAD89CE
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 12:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE5A67A94F8
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Jun 2025 10:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7122D29CA;
	Fri, 13 Jun 2025 10:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nme7ad6/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD352C15B0
	for <linux-hyperv@vger.kernel.org>; Fri, 13 Jun 2025 10:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749811636; cv=none; b=D1p21GRt8BPgfbpBEa3bf8IH40qxPN45LDgzFrLECntCa5LjmkPF1wN0uWGTKoHicijfEzYvYg3iM03iZEmhGSk4+B4OhCgFYE+2ePmnUrADwQenX073BsWwHmUsgslvd18RNWMCjkhFTRlmsr/OPdEdm6BTjkuvvSNF6jWKj6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749811636; c=relaxed/simple;
	bh=OXsuLS0c9D4ArOtlmGYmkIGIKFar7ciL8P1aRFLVO+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dg7AxDd92LhQ8LkcTQ7b4vcvjM4+RUqcPNFKy4eBUpfXGJUQjisekWgLqW6PJ26tm1aV3Oeu54gP56vyPWzCDqZ3SQGtPiUiD9klvVFJ+mGkYiIEa3Tv8LNpSQ4Uj7zoWEZUAAUns5zxVgcVzuhVEtRkM5f7ZGSI/SmxlzWwEo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nme7ad6/; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6facacf521eso20470256d6.3
        for <linux-hyperv@vger.kernel.org>; Fri, 13 Jun 2025 03:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749811634; x=1750416434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LmthMQWFmJ1h/Ibp+KKaUVy8hKroUZUcjmGRyuSiy34=;
        b=nme7ad6/P91laQ11g7ARGXi8ltugTZzqpY8SqgDFPeGoTRXN4mNkfcdV3lmLqophlI
         LtUX8R3vzmSdmXT7Yb93/0BXWc2gbl9hOwS5cXI3WKUzD/YwCIvq3vdfjsJ8I5//F4bU
         dX1xR/ieFq1YtlBRErB1hYtLuvcFKA/SqP5eFIH/9xd2iVcR+3HS97uEkZxYTo8MWzez
         prrGBWLvMNuSHTaGKVbR9uOy+X+3nSvU9oka4e294APWgK/+Dk6BupnQiNZ+R67sgimL
         VHUjaSzPO1K6Ct4XAa0OruU9X7zLqdUIxWtGBRLytWwkkUXSy3s6rukDmBXMF2BolUIf
         z6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749811634; x=1750416434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LmthMQWFmJ1h/Ibp+KKaUVy8hKroUZUcjmGRyuSiy34=;
        b=HCfA3T/ZeUB30X+KMYVRQ+tuwbD28wxmXBQcMcyfPQ+In2R9DDXxk8iHcZSsr9+in8
         KvHxxOWT0NvqM8P5Gbre5fMaPx4E2TMmxnpgK5UpCb0fuW99BnUnDNYRCsJ7VvZ8pYsI
         5AWaVNrstOvHf6FnjKwiTyS2+Q04aiLoKx7MwyweWai3mRrdo644yWRvOC+v2LLdat75
         N/xV0qp7/Mq0c7gehtB3kFwJzPEsidg2qVbaL6dl4rcuyZXQHkWzpG9GT2WfEcjanIES
         QTAV1VYrf+f7pMXF05v4AjO4EdovOW4xze2RYRWfJL8rw4wVswYbTqbS1zfwAGlzK+dY
         4sPA==
X-Forwarded-Encrypted: i=1; AJvYcCXFF9f6zEzHRldx8oRvDYeJPlxW0LFgX7KnrXq6w3ZRGLleg1h/OPLAH5ZtwcyD1EOikgTu0P8yKg+U7OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUBZXEo4XGMVQ8dGfcujwMK/BBHBs/gNcKIv6JrB3r5m4PNDN
	AvQwq+jd2eN2luZPUkIe39ksEEdPJk4asruRmvongH4Z4rLeYN5JUOifcGQHtHUR
X-Gm-Gg: ASbGncsTfNrQaD+I0u/Dvt4tMWx6frt969M6IIWjsdqlQ+fuRqENTwPUsdfHqlaqmq/
	LeXK/t8SWpuCdKivYYRb1DkytcJcSU/P6ZezVnnpLLWbDdyLlN4MciMnPVg5xGBIWFgdWAJAMLO
	vUoAuHzh00faOo7yF6pkiTvw1b4ojUHlV1LTqMjKr8RRSRk3ZCUcxFuhrjgdH4qtNqpS10t45FM
	KLnXoVCMvek+JsC79Sk8Tw9pAKtIS4z1RWeXMMPF15nTiVLyTfxFBf4Mb71iiu0a6fJ2d2WoZnN
	mDLG2LXpfZmpm6/Sq0oujmnvKBQZA+9PkjkK0U73gpIkjESCWKXx4Ub1lhivS7oOJnA8RFLPgeJ
	Cmdc83raeEK+HxGIUBUfVXyb/w4F0vv6U8StA/gU=
X-Google-Smtp-Source: AGHT+IFE8J8VrU40T8G7x+JZPBjKFUix8nq6qRM+iP/Fg3cj6FOehvN02U8UvPHbDvMYXNIDpLypNQ==
X-Received: by 2002:a17:903:244d:b0:235:5a9:976f with SMTP id d9443c01a7336-2365dc0d18fmr47085115ad.24.1749811620503;
        Fri, 13 Jun 2025 03:47:00 -0700 (PDT)
Received: from fc42.mshome.net (p3711121-ipxg13201funabasi.chiba.ocn.ne.jp. [114.165.124.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe169205dsm1363759a12.74.2025.06.13.03.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 03:47:00 -0700 (PDT)
From: yasuenag@gmail.com
To: namjain@linux.microsoft.com
Cc: eahariha@linux.microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	ssengar@linux.microsoft.com,
	Yasumasa Suenaga <yasuenag@gmail.com>
Subject: [PATCH v4 0/1] tools/hv: Fix incorrect file path conversion in fcopy
Date: Fri, 13 Jun 2025 19:46:47 +0900
Message-ID: <20250613104648.1212-1-yasuenag@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yasumasa Suenaga <yasuenag@gmail.com>

Hi,

Thanks a lot for your comment! I updated my patch:

  - Update loop condition to exit in wcstoutf8() if NUL char is found
  - Add new syslog message when the path length exceeds MAX_PATH
  - Revise both subject and commit message

Can you review again? Comments are welcome.


Thanks,

Yasumasa


Yasumasa Suenaga (1):
  tools/hv: Fix incorrect file path conversion in fcopy on Linux

 tools/hv/hv_fcopy_uio_daemon.c | 37 +++++++++++++---------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

-- 
2.49.0


