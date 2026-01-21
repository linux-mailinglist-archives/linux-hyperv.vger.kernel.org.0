Return-Path: <linux-hyperv+bounces-8429-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHv7N99PcWkvCAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8429-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:14:55 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D18555E9AF
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB8E5582F87
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913143E9E0;
	Wed, 21 Jan 2026 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTE3V2XF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3635436352
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 22:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033527; cv=none; b=qbzNGb3Of83WisrGr+ihzO0UKCtDBJA5dfAQ0cAjrYW+AZlvGM7oj6o6T9RUsITvHIOpdYHn5aAfT8DmWhs2N20p/D/AK5xPDVK3IqOSh3mhnYck1pGMIFTT4jUAopHa+TUimxytRrw5efVvbOn4Uyb8YlifSLJNs6+gnXILSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033527; c=relaxed/simple;
	bh=QFGTndIZnCvd5tocHyARHg0OdzlZifxdeujSy28wwJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5LCIIG+/IRfwH+5EgTun3EDeaVWAUb8ZNHc2FquRkMKpxYPyPHxvBQGRnaL9DudqhEnpAGxUCew6AOoeYxZgMI9E6N6ngwtz07joDr9L6symAAnVndMFehCIYoUbkKQ4LWrSmmVQTTboSZ6hc8Ho+dMq0hFOUfGhUkgOOf9ONI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTE3V2XF; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-79274e0e56bso3763917b3.0
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033522; x=1769638322; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=fTE3V2XF/rfgkDTJ2zPRvnIk73uupZBp4RuazKysKvb/4LQVJODMvJkjGSAFTgyhQE
         +o4Qr3mXdbLpTlH+cjE+RCIw6jGSqjzYyQJNmdno12VNY3OE/UDwZaOggZ0ZEyqIisMz
         57jizkfkmwQtZ9i2EvNW7PKAmumXp7Bsmxefgyfeg7/Dej/5XyZ0goj9FM9vtQY12cRQ
         bqFM/uSnnryGbWTz0Efz+zSzJ+piIfIU5/hWZH/iFts4L1iGVi9n4tMbvoZMpCUPe6mn
         HPbSPhT7ca8U+rEb5pPitYGPLMg/duUXNWJG/gBMfocQRwE5t3Wt1idyalsbddxilldm
         dgmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033522; x=1769638322;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=unH2wCss0Ty1VvUDTNIEbPTmQV3pZ3DC4LFLvQiSkksu33eUWo5jB85OxAIAtWyKjA
         mhEnC3C/vBd/VdtHVgqxXK/5DDVFlqwIEiqxNMsFnhw3Q9a7fajTWkq2MHhr1iIIpvoO
         7Xbi8HM0NAe+SktGCTPHQ7MAzhRG66ZMUsYXgUo6qfBc5EmW+SHVFAUeH//W9Q6uAte7
         Xu0VCD7iuqfFdAeK5TgGojFU5427xfZXwmd2rh9Mw6HD08SDiJU/yEnagAfCmblhTjmU
         cfbq28S1dQnaaMbFVdefPbTPnUFvnkynCrPTnXdzKT/TRnu9fg5C9ONtBogMviTWeeYv
         P3Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXr4i0O/7VcEGzz8Z99Fznm1UDRcZb9v/Qso+qcCYsGIKKWgOKEu8Sd4lfJDTTswg4pOmC/BTqHjd2yslQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvBCLQy2hgzae4I+y+MVocrPYDlCJhdkBivTorH9723z3u4HFT
	N3K8pMnq14iVOU3aSD1NG8CEm/dpb2hVNTFVhHc2TlBTHzCrsFkxXX78
X-Gm-Gg: AZuq6aI6I5a19iRQmmqoYfEm2+bDsUfk7vYc44d8pB/E0HEsx9dNSY+sMmx4rDzB2bI
	2954Md1CYbGaHIC94Q0OrLgcARsExsQPSS5cXSKNoO3DKHkuQ9oPY3DfEgVLPn58/Kl2wlfkHoC
	2dDN3yn0/2KTLYd5yyT3a5fPKoq6LN1X+ROsddXqHzNmFQZcJ+6AO+Oo7+drdAAAJi1BcuFEkPA
	XLJgnuafc/hnte9gtossD9Dq0Ih/TtD+SMnElPcNEST1qVhj5InIMMk+AC4PIbvTp9lkTSiOmSS
	UeW2MIo22wtfHnBC5vCfB7EZNgxbqThrnhztxYhPf75BytY6y9hAq08Y3H3+eI9p9EVEjgLkZH6
	QdU2SMLa6NOZFb3KCfuw1wVVCRu0zrRtlgEEX5pgk3GCAxo5JTqq/6Lsv6NbAGatt/Xz45Vq8wm
	yQbPmJDPXz
X-Received: by 2002:a05:690c:7204:b0:786:a0fb:fa8e with SMTP id 00721157ae682-7940a11e123mr58055607b3.15.1769033522528;
        Wed, 21 Jan 2026 14:12:02 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79415015f4esm20243667b3.22.2026.01.21.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:02 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:44 -0800
Subject: [PATCH net-next v16 04/12] selftests/vsock: increase timeout to
 1200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-4-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,sargun.me,gmail.com,meta.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8429-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D18555E9AF
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Increase the timeout from 300s to 1200s. On a modern bare metal server
my last run showed the new set of tests taking ~400s. Multiply by an
(arbitrary) factor of three to account for slower/nested runners.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
index 694d70710ff0..79b65bdf05db 100644
--- a/tools/testing/selftests/vsock/settings
+++ b/tools/testing/selftests/vsock/settings
@@ -1 +1 @@
-timeout=300
+timeout=1200

-- 
2.47.3


