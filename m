Return-Path: <linux-hyperv+bounces-8866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP8PKIxIlGn0BwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8866-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 11:53:00 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1894714B051
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D538130233CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 10:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A90632AAA2;
	Tue, 17 Feb 2026 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R2iXaXf3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B469329E61
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Feb 2026 10:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771325577; cv=pass; b=sukos8Jx8bP58sdCBaLOgLGeN2SvjluCHnX1wuTolVtvRr43a/w51TiyUkAqoCjVqCD3q5GcA8Un7H3V2PjMT63Vesc5qpubQjOb5LcviBY2F1oT8YBhzSc+l4lPC4oTasXG8FXCTGLyejZaie6f183TvurwsX8+KiE5/p4mgi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771325577; c=relaxed/simple;
	bh=UVLDdUyfYEHWM0Wp3sdxN4gUNUhd0j7Qskt5gVnAJyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L1puDJbhYN7xBo/I5HLYE6h512siu64xOMyWB9s9pgPll8ieWiwd1SoRj4NUseoDBeh9mlQHQbWDPhemtbavadPCDaTRRW1A2wpfPP2jopnuKG31a9MqhJWN4+iBdHyKLeBoRvQU+cz7bN9yOHXAwva/5XEZu3WxCrGRs6P1egM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R2iXaXf3; arc=pass smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-8954c181830so49164966d6.1
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Feb 2026 02:52:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771325575; x=1771930375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hOqbwnHYhH4bS/t9h8D3vjqJhTF23EJ/J3eVn9UxsA=;
        b=DFjCkvJMCfmvJWnKbCAXF6baFxZYBib00rgALOHKiNSAqMoFoc7z+CF/XKTd1yqPFA
         ltwC/x9CfHHofaYSqwCRDQ4EkGoBjQwDkC7cv9ggBEMyRP7CPTQWu4pmBPeEKPCwgWtU
         0ESwDFvWIKcoykq9WRVE6MpZLHBWILhWrAJQk8qv8xJuoUjFvkdZvzvI/AEDdDyM6hLX
         uf7yfG/JbqnUHZHna2I6ipWJcA+D6c5b8Y4vmmqyFkiPLb+86GbSv716/2CUCOI7iW6F
         ytzsfdEKPoojI5elouGllbS2Rg1o0FaynxA+lPByG3qcAvukSM8cI/H8oluz8cZUA/1E
         k4ew==
X-Forwarded-Encrypted: i=2; AJvYcCULexjSiXGpoEkxtIC2yNy1JUXSvxMTMbx99LRhgVUvxyjfo8R4HGGEf5Zu+5mt/R4+4KdVViJMxvwQkr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUG3qf8I+GzNNGpdbCLx258SqsWrBeN19jldcc0x2lMtT+S8r
	d3KA5RmDUspdmDq2cFmj4AeT76VCRBTjQUDC6d0vGppYKGxur29umHeGFCD21uCpmOTOXtt/tI/
	i7cLoQRcYojAF3t6vlhUGXSqKZdARbsFfhsp84rGzzNU9vMBI93PLVbycmip5T4pbk1ns39W35Q
	FvLxkgNpz68r17H6lSqkxXLfQqXun5tN2YB+B/h3F4vCkPpsOjM2xUeHCtANCgLHnZTzccIq1G+
	TCfq/JPCRtQtw+6GYOW
X-Gm-Gg: AZuq6aK+qZ4+EUqBqybZZGVwtIuY5ZxsejTRl+RN75byugDRmKruT1Blre/qcEuaHVq
	F9m+mL/qn7s6n8F2ODYPBZ7JIRyYirrKyst+UxC8fz1mnA5I2UW2xoMVi7vuKjWwEF1xHqyVkoj
	0MPYbbUdRVy8LOpNfFg/B3/5+D4/xmEmZtcZWLwDwjDh4mRgmn0VIHEKgcBmxGR2fSnPWzydOsb
	tOvOBRgeHBrb8ataUi2W8/mLeo1x4vuMfJl9CNlt/pDejtZmROz58gKoMo8BN2wVRuE557VsPQn
	K3SKdbs01yJFZjh1mCDgfJAI0fBGu/l1Wa5vimtmtNrn+sALCDVnm53eXQjb1bkIEpi3sEqUsyH
	nQxHj4GUb6OguaaM44gjmSdEzXcECGn+1CCBgGAZPUaN/iq4yL/S8u8eAXJRxseHqAVIpDFkW3H
	yto6onP5UVqEd+34FBnT1FcAC2NlSJTGVhVV39m7Q+cOHGwfgU11pfdJzEPEGw
X-Received: by 2002:a05:6214:124d:b0:894:2f5b:fb98 with SMTP id 6a1803df08f44-8974047bc96mr165309616d6.38.1771325574790;
        Tue, 17 Feb 2026 02:52:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50684a3e9fdsm20014521cf.1.2026.02.17.02.52.54
        for <linux-hyperv@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Feb 2026 02:52:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-65c04f407abso2611797a12.0
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Feb 2026 02:52:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771325573; cv=none;
        d=google.com; s=arc-20240605;
        b=l3TSgstzVaT5ardXCoIbW10SHh9yMrEQA6et4m9hwiaWepsRAJIq1fXenlTpc/MSjl
         PGyHK7A4WA/7er0TedogbZI4A5Y1r5Bv+fqTis764yHCKAQPMt4FcK92cS9AX21+EM+0
         pJbXvo1hPDSa2EqmhHF9Oa3lsrt+i3r3lhvP85LTVF3Hums/JGNjPpQCBj/jJ9ORuKsS
         cSwuVK6P7C4Ok6oO+RbqZim1/m3xb2C0w+R3jUn7U/Ds/xV2TV40XuL7wMsmtxtN8gYw
         JR8uIVTMiLAR8FxsQ5YW5ZZtDw/tSzdc1u8xNlmFLt/XlOJyJrX+HsrGSr6WsFLqZvgE
         UgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1hOqbwnHYhH4bS/t9h8D3vjqJhTF23EJ/J3eVn9UxsA=;
        fh=qi3VoQShsK4rgVahlYq+7yrfHaNiz809p9YqNJ3YSUs=;
        b=eB0FzVVBPsec6urcZq1HvdvTwdQKqzS2KGmd2joXquDMXGTM3yjDlHIA9oRisWhHdG
         UvAScL2w6svMmDvq/A81cRZxOJ5JYc7r2u4FlK35tDiQ/UZoEXd6obDksFmdOE0nIqrd
         O15EuRB41UlirWSY6M0hTPY/hl76oqj44TJFZuHYa3FDQul7cWUK2j7WLeTvFnPNyu5H
         v2drE+Q5md7+doFVgs7asX+7gTP1nj+c1zSXjaoHILn50bcZ3XTJ4MYNQVb7XClKhcs+
         XxBipkmFn21HPOlvmM7fvZCmBnjsqGliT4sUTh9wXfUEM8sYVmsPgDjLTxXG2K3NnUVK
         0CFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771325573; x=1771930373; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1hOqbwnHYhH4bS/t9h8D3vjqJhTF23EJ/J3eVn9UxsA=;
        b=R2iXaXf3FvmTfbssgdf8j5y7SDjtzinf8ttZ5qZ/UlbEla4LX3xlskCkoIe43QF2Xn
         HN6kSs53Qp4COjOaYTX7x/zIBDQ/jRedp4z8DXFYuv90lUvNX+nA9lO0LcCDlP7zBAuH
         0J3LeWtOFPMk60cfC5Oec3+yZ6SQQy2JiwPG4=
X-Forwarded-Encrypted: i=1; AJvYcCUlOPPfpC6r31Hdxh9XA8L69BNtAZvK3fGvfmFF2neYeoXaixzM/KTMMncy4w5fCadCHw97tKZghlVB1dQ=@vger.kernel.org
X-Received: by 2002:a17:906:794d:b0:b8f:7aa8:d9a4 with SMTP id a640c23a62f3a-b8fc3a34ecdmr627257766b.20.1771325573145;
        Tue, 17 Feb 2026 02:52:53 -0800 (PST)
X-Received: by 2002:a17:906:794d:b0:b8f:7aa8:d9a4 with SMTP id
 a640c23a62f3a-b8fc3a34ecdmr627256066b.20.1771325572658; Tue, 17 Feb 2026
 02:52:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com> <CA+sbYW0Gh2bLoPZKzH9u-EcWDTz6mbF3RB=6Q3q=m7YpUpNU6Q@mail.gmail.com>
 <20260216080746.GD12989@unreal> <CA+sbYW0Ba==5Z5fyqjBS1AH8HE37ese2qMiR4+hoY-i8pajzQg@mail.gmail.com>
 <20260217075654.GI12989@unreal>
In-Reply-To: <20260217075654.GI12989@unreal>
From: Selvin Xavier <selvin.xavier@broadcom.com>
Date: Tue, 17 Feb 2026 16:22:37 +0530
X-Gm-Features: AaiRm50pFnvfULmvvjmsfbQVjgfZoPVNw14CX1QvQuh7opugOy_arccGuECPQl4
Message-ID: <CA+sbYW2Bzis0E-pLKZ_j3T748YeB8Bt_zM_t2pzh09_TGoUnHA@mail.gmail.com>
Subject: Re: [PATCH rdma-next 42/50] RDMA/bnxt_re: Complete CQ resize in a
 single step
To: Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
	Potnuri Bharat Teja <bharat@chelsio.com>, Michael Margolin <mrgolin@amazon.com>, 
	Gal Pressman <gal.pressman@linux.dev>, Yossi Leybovich <sleybo@amazon.com>, 
	Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>, 
	Chengchang Tang <tangchengchang@huawei.com>, Junxian Huang <huangjunxian6@hisilicon.com>, 
	Abhijit Gangurde <abhijit.gangurde@amd.com>, Allen Hubbe <allen.hubbe@amd.com>, 
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>, Long Li <longli@microsoft.com>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Yishai Hadas <yishaih@nvidia.com>, 
	Michal Kalderon <mkalderon@marvell.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
	Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Christian Benvenuti <benve@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
	Bernard Metzler <bernard.metzler@linux.dev>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-hyperv@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000971448064b02df6e"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8866-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[selvin.xavier@broadcom.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1894714B051
X-Rspamd-Action: no action

--000000000000971448064b02df6e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 1:27=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Tue, Feb 17, 2026 at 10:32:25AM +0530, Selvin Xavier wrote:
> > On Mon, Feb 16, 2026 at 1:37=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > On Mon, Feb 16, 2026 at 09:29:29AM +0530, Selvin Xavier wrote:
> > > > On Fri, Feb 13, 2026 at 4:31=E2=80=AFPM Leon Romanovsky <leon@kerne=
l.org> wrote:
> > > > >
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > >
> > > > > There is no need to defer the CQ resize operation, as it is inten=
ded to
> > > > > be completed in one pass. The current bnxt_re_resize_cq() impleme=
ntation
> > > > > does not handle concurrent CQ resize requests, and this will be a=
ddressed
> > > > > in the following patches.
> > > > bnxt HW requires that the previous CQ memory be available with the =
HW until
> > > > HW generates a cut off cqe on the CQ that is being destroyed. This =
is
> > > > the reason for
> > > > polling the completions in the user library after returning the
> > > > resize_cq call. Once the polling
> > > > thread sees the expected CQE, it will invoke the driver to free CQ
> > > > memory.
> > >
> > > This flow is problematic. It requires the kernel to trust a user=E2=
=80=91space
> > > application, which is not acceptable. There is no guarantee that the
> > > rdma-core implementation is correct or will invoke the interface prop=
erly.
> > > Users can bypass rdma-core entirely and issue ioctls directly (syzkal=
ler,
> > > custom rdma-core variants, etc.), leading to umem leaks, races that o=
verwrite
> > > kernel memory, and access to fields that are now being modified. All =
of this
> > > can occur silently and without any protections.
> > >
> > > > So ib_umem_release should wait. This patch doesn't guarantee that.
> > >
> > > The issue is that it was never guaranteed in the first place. It only=
 appeared
> > > to work under very controlled conditions.
> > >
> > > > Do you think if there is a better way to handle this requirement?
> > >
> > > You should wait for BNXT_RE_WC_TYPE_COFF in the kernel before returni=
ng
> > > from resize_cq.
> > The difficulty is that libbnxt_re  in rdma-core has the  queue  the
> > consumer index used for completion lookup. The driver therefore has to
> > use copy_from_user to read the queue memory and then check for
> > BNXT_RE_WC_TYPE_COFF, along with the queue consumer index and the
> > relevant validity flags. I=E2=80=99ll explore if we have a way to handl=
e this
> > and get back.
>
> The thing is that you need to ensure that after libbnxt_re issued resize_=
cq command,
> kernel won't require anything from user-space.
>
> Can you cause to your HW to stop generate CQEs before resize_cq?
we dont have this control (especially on the Receive CQ side).  For
the Tx side, maybe we can prevent
posting to the Tx queue.
>
> Thanks

--000000000000971448064b02df6e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
zJH6Ivyz2skA36zh/px/UmF2ORX4Y0CY6GtU8/vxuN2j4rd2medlyifwALUm+KI3SsD782IwKLCf
8bNhYGiw4YxsbyX7dV7O4SNQc5U9ktrSKH3D4SuTnK/xdjca5PiNI2NTcBVmP7+u2bvVLdRqISop
9dpRkJ6xxhGJjxakljIxHdcZLXltxX4YM0Onf3agcjY3boIqnVlDjBwSZX674ZU+YVrcIlcRcqs/
W83e6PmIRFwpkKOhuLNKSpW5mZoEQdpnxGwE9U7qLGECAwEAAaOCAd4wggHaMA4GA1UdDwEB/wQE
AwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDov
L3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5Bggr
BgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUG
A1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUF
BwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDag
NKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJQYD
VR0RBB4wHIEac2VsdmluLnhhdmllckBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYBBQUHAwQw
HwYDVR0jBBgwFoAUACk2nlx6ug+vLVAt26AjhRiwoJIwHQYDVR0OBBYEFJA9fV7cOoiN64ws5XPC
J5qtayo5MA0GCSqGSIb3DQEBCwUAA4ICAQBFCIF4AxAiXVz6gX5YfFEbIYtbGFifcfe+QGc5cfac
CSzIrQWUPXAYAef3G5WouD2AKwa2tPGJgK2L7n1r2W4NIvr93588EDVnGgfMfWaFsB8VlLsPlH8Y
fLfaTdN3OQPnFFp54yK9wv8AtTIiTQcailMw7QX5x5GE6HVZElxf0V0Ljc2NrUQLoYzHzAU+sysl
6JQzomxjIfuXiIiUfmnWQdhO95kQchRdOUAaguLTV+RRfPZ1p54dRmgGEpJtzjGLdsrLkZ2rCN5j
cOTTXyxJmvlgm9jfT0Uy5SOPHdq1jtZbQyXrNT4fQ07Odmq3xQCUTi+a59IiC+6V7nFJ8zyCSk+p
n/iGouvun/owYzTmFxB6sVLWZcaWz2Ufcm7b6nOYV+pwUS/n6+6oFRKmGLrl0CRCF0AOph5p81aV
kgKuS5oXBoDefJfjKHuu5lJVelBx3n++iMGMW9FWFmXErCHy2d+L42Raai5X2PL8jAmh+lpPRDX4
CT9jL6xWM5QkCBtxyVKuxGxxUY2wczmVcQ1nGh9mGghI04Scs4OtE8Qh9LMOe2PXzxcV6lpF+yay
B3fwJWxl7miwNFjWuu9M6Z+rcjm3JF5srcAu2fp/VzQD4AE5Kq7ywukMvlU4Y3X2t+D2eU1DH8pk
c8mM1CtQWfWUboaoLABVmYmYfihDvTURkzGCAlcwggJTAgEBMGIwUjELMAkGA1UEBhMCQkUxGTAX
BgNVBAoTEEdsb2JhbFNpZ24gbnYtc2ExKDAmBgNVBAMTH0dsb2JhbFNpZ24gR0NDIFI2IFNNSU1F
IENBIDIwMjMCDDy76dRYp65lyF2c4zANBglghkgBZQMEAgEFAKCBxzAvBgkqhkiG9w0BCQQxIgQg
b1hwPKHySU90nwh7+UDcmmXdwAl8q8EGRRhH5H5qH3IwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEH
ATAcBgkqhkiG9w0BCQUxDxcNMjYwMjE3MTA1MjUzWjBcBgkqhkiG9w0BCQ8xTzBNMAsGCWCGSAFl
AwQBKjALBglghkgBZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAmhxOCznDAJp6sdGC0fy77NeK1mzN5i0v7gU3
iOSZF6GTSEVDFNvHuFA4zoBTEkCTh+34nbiRVHQc1+QFrm4m68dF7cTgJLFECYNLQIRuQ7NwcPU0
TpAgy1Uu5Mo8O7BUAr9CV1AeNzbZM9gpInYVOBrswNsDfekBP0iqKlNrlHLMn97f707z7T0E/EEk
oKwVZtoqHYo/SaQ4Xl5aqJBPnlUXlsjzGvQ1PYgLXKRpQ3VOgnaKcPmOA74g7SLm5aK0gq48EyFg
q/EsgsT6azwCZAAg2cD3ppcxAAt21H+F/SORQw3s3rhxstDuapJj5OjmNhUKP7VCzeYtXrMkpvSJ
EQ==
--000000000000971448064b02df6e--

