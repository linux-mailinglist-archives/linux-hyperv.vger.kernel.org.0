Return-Path: <linux-hyperv+bounces-10091-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPUKN4cJ12nNKggAu9opvQ
	(envelope-from <linux-hyperv+bounces-10091-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 04:05:59 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DD93C56D3
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Apr 2026 04:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 928B330106B7
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Apr 2026 02:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145ED366566;
	Thu,  9 Apr 2026 02:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8AACEqm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4925A3176E0
	for <linux-hyperv@vger.kernel.org>; Thu,  9 Apr 2026 02:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700349; cv=pass; b=Z37CvhS6jXXZiZFLQ7+1bzHCqukrCZksChlzNvBiRTgCz71pwp1bcEYPy6IGTmpiXYuxwJJIwVF3pGoalQ5szgAPF5m3ZrKpsW6eB1TiNtz+YEJN1ievbaqDgDIWzA1JQNVGd3FrUdEjXSOsUCTG59isVSttxDpBYvsqNB/mf9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700349; c=relaxed/simple;
	bh=UeTwiLfBg+d0J+5G2B+h5pJ1GQXFcgWjEGVIN1kl2GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5hZLSKrTUVB5xOsUS3g78yPKoYl4t4MN9NoY8jSixns7XpAT8wvB9N2r/zt9U2iVd91/rTpYM/nYurkUnoucCoj+pO4kWtG3jekkN75O09bN54OBLx5G9SFbmo0rLX/xBijZ8xN2+UX4PzZjOhffoLDgBgu8Xv4Yq+ZBiwkqmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8AACEqm; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b6b0500e06so266807eec.1
        for <linux-hyperv@vger.kernel.org>; Wed, 08 Apr 2026 19:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775700346; cv=none;
        d=google.com; s=arc-20240605;
        b=XSlY5OGsWrijAqarK+t3+KK743gJIpJ8CIGtKXk3Tre/JtdSkepGhrxhcUxFz3rQmX
         iVJ/YuK4lHoklz1tqeo18lfZp1TD3ZhOaxFTDGI4y1MvPfiUWh1Eb9On9WjDNcV7XLKh
         9Frm+xMLHG0YuzCbKAP+ZR6JYWojMWQjpdbyVe5d7H5jLycbnPFxKUdaYZv70/HM4ARY
         3ntBiYTK/PsF4f+nomOGNo9HuN0pYRIXTbIp/B6cqtyzvzhmm4BfRsIpJthdyuWCp/fJ
         EdUW5P5IzrbMbyn26mn4VrFxbEqEvwe9QbG5uLTU26/06WB6hPsRXaQrmdPcJ79eAx6b
         6ejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SLQ9FL6B7CY5WwBy7xgt5VJrNvupBJ8idCTyKNGIzh8=;
        fh=jwZ6hswX6gZCKrGjHx6W2ULoBhJnmTmbUPh+bZLXMds=;
        b=eA+xqgmFjKaKGLRLLYUa1K0/wU5QJ/rbAic+oj68qbjyuCib9E7AUMm91QrjaN6uuK
         poes6es/eiFpYy+v6Z5/On7MS/IL03Pmb0rUr7g+fEzjIexPRxsKLQaiS3bB4F+anqji
         K0QzQ5AthoWcmiTc+ENemokdxC93DT9Rxc7fUkcWNLgo/WdkPcBzCrIxy+k8TGJUU/oW
         M7jH22VrZScDaslu97FXBSNYpo0dyFwrus1EQv8dsFTLdl0LMSJyeCxmOPilPLkIkR/1
         BqH3qIBfeOVwjqa9iw6/ewH5gl88pZgSm/Iy68PBFv/LyNJKIFzSHKqoB10m3VmbNh5d
         739A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775700346; x=1776305146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLQ9FL6B7CY5WwBy7xgt5VJrNvupBJ8idCTyKNGIzh8=;
        b=S8AACEqmzwS8lTf10DqZ305lkXH1MmlYxMNNqeIM0394QGTSrQbHyV6SiTH4qCniKd
         VB15ebwsmN19LU4k1k3CBPK0EpnplDZyty8RpGSl4n1WPcddGJIvjPQnXeH0BZdrQ9gR
         3qhoqWkoCiSAm7sMBKzKPsvBjPfBlFOVSfe/Y/KAxdmEdOWKDgwl1g7YOTaRFu3ww0ti
         HhRf8LtnMy+8bqDUJaU4HYZ8NYaj1hWcrAocnk6zSudloyKvrAoZ3ockFJMHLOMD8Mud
         C8ZpjZRNP65r32LKpH5dNpxu1LqpKWPDFtiqkz34rX+lZ8TxKArQ3gr4AxYFtHy173zi
         ZNPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775700346; x=1776305146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SLQ9FL6B7CY5WwBy7xgt5VJrNvupBJ8idCTyKNGIzh8=;
        b=Tz7mTLwY3BqR1XGFgrelvnZiBlEri44ptGk48/zepWsR89nC6R/zJ7R1fgcM6cimjj
         J7itJ9NHy7nep+c807Kjzi51WLI0d08HQQaFZStOp4dZPOmBnZXXSwvoXCwwyCLMWPk5
         TyBcbay853ysp7Mv6+atg9BugLrgkANCJBmEmuaMdrcx+PQ7UydTyeD5twqskhuxUCyE
         l7559ifA1kB+xVczXnsWGNJ+GFCEY7vAt0dHR9hBOzpdQk8v7Q1DhCLzu5wJNqiDGygm
         h5DSFydaBT6yxAV4d0b7lZst0z1Gl1pIcbZtd+2dA53XL5cuNJ8qmONDxwF0Tj3JtwFi
         GLUw==
X-Forwarded-Encrypted: i=1; AJvYcCXGDd8m6p3dwoRUx7Vh1dxL0Iw5BfsCNG5RZjQ7q1cbkWE7bYV2wVOTUjyt6m0+QT4MLMmOKjs/ZorzQcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEz1odiIYhe+SMAubgHp3jd3gTed9ayZx59qFqAmP2AKU7B+rD
	NzVNUD7c9WxEF8XboyCcYQW8b67XQrq3A0vpbAc2nJfomkEyVNf83a/8cVc9UXRv0d6aYhkbDCb
	Rq0uupNaSbriEqJS6Hp9jI9OwJ1YKmQI=
X-Gm-Gg: AeBDietun9JwCWmzDPDOYpmj2ToaV0xeZSFrEzGrlHTqaPt9spJabfh2f/Cx5z7+Sov
	56slv9MianWpudKWvlElKKp0uhGY0nFvottC1GbVkKPoPdOZsIUjwuNS/TQ16SI/o5bpUuJaGXm
	fvygxpGmD4E6mE3WwDVfVrPB5GRoMM3GtTsiyhkuekS9XQh2PWMwMKiTIzKNGt3jJ+udQQ+J6+s
	N9ymx6lUiVIsGPDUW1RHOY8n+mFEaZNnj+GDarm3L68GLdYLu0kaD1LMnN6jL8wpdt5O43kuLeN
	f4UcwkaED09jSbnnvQ==
X-Received: by 2002:a05:7301:490c:b0:2ce:54af:778b with SMTP id
 5a478bee46e88-2ce54af7932mr6799136eec.26.1775700346235; Wed, 08 Apr 2026
 19:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408073105.272255-1-tiala@microsoft.com> <2a80b7a6-2cfe-4bd0-a799-ff855df7bd41@linux.microsoft.com>
In-Reply-To: <2a80b7a6-2cfe-4bd0-a799-ff855df7bd41@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Thu, 9 Apr 2026 10:05:27 +0800
X-Gm-Features: AQROBzBzEzYGBNkJ3Lc_cJV9swgWDuwSma-hhDKuy9WuT4xSdDRp7MADvaPkmmU
Message-ID: <CAMvTesDJv6h4kSR=M6JD5h6h8NOAq9_2qvm9kY30o-BkmWWMJw@mail.gmail.com>
Subject: Re: [PATCH] x86/VMBus: Confidential VMBus for dynamic DMA transfers
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, longli@microsoft.com, 
	James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com, 
	apais@microsoft.com, Tianyu Lan <tiala@microsoft.com>, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, vdso@hexbites.dev, 
	mhklinux@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10091-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kernel.org,hansenpartnership.com,oracle.com,vger.kernel.org,hexbites.dev,outlook.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ltykernel@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,openvmm.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7DD93C56D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 12:55=E2=80=AFAM Easwar Hariharan
<easwar.hariharan@linux.microsoft.com> wrote:
>
> On 4/8/2026 12:31 AM, Tianyu Lan wrote:
> > Hyper-V provides Confidential VMBus to communicate between
> > device model and device guest driver via encrypted/private
> > memory in Confidential VM. The device model is in OpenHCL
> > (https://openvmm.dev/guide/user_guide/openhcl.html) that
> > plays the paravisor role.
> >
> > For a VMBus device, there are two communication methods to
> > talk with Host/Hypervisor. 1) VMBUS Ring buffer 2) Dynamic
> > DMA transfer.
> >
> > The Confidential VMBus Ring buffer has been upstreamed by
> > Roman Kisel(commit 6802d8af47d1).
> >
> > The dynamic DMA transition of VMBus device normally goes
> > through DMA core and it uses SWIOTLB as bounce buffer in
> > a CoCo VM.
> >
> > The Confidential VMBus device can do DMA directly to
> > private/encrypted memory. Because the swiotlb is decrypted
> > memory, the DMA transfer must not be bounced through the
> > swiotlb, so as to preserve confidentiality. This is different
> > from the default for Linux CoCo VMs, so not use DMA(SWIOTLB)
> > API in VMBus driver when confidential dynamic DMA transfers
> > capability is present.
> >
> > Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> > ---
> >  drivers/scsi/storvsc_drv.c | 28 +++++++++++++++++++++-------
> >  include/linux/hyperv.h     |  1 +
> >  2 files changed, 22 insertions(+), 7 deletions(-)
> >
>
> Does netvsc not need this same sort of patch?
>

Hi Easwar:
     Thanks for your review. AFAIK, storvsc support the capability
We may add such change for netvsc driver later once netvsc
also supports confidential external memory.

--=20
Thanks
Tianyu Lan

