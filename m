Return-Path: <linux-hyperv+bounces-8865-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBpJJlcflGk1AAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8865-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 08:57:11 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0129149759
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 08:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 501613001FBC
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707D02D9798;
	Tue, 17 Feb 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e/tr0o2M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42E2D7392;
	Tue, 17 Feb 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315026; cv=none; b=u1ner2a3RjV5Rm0zvAjil+Yl/6iLaFkD6eSO534ti3O8Puc8FHzhYlKmR6LPs31MGy34Ht8/8xFLO9KwzgNtNHoYHGIDidk2ZHxFCUCWnOfLQRdsix/HiESf2JTgbniOwFJD6p/jLBZLPLDifOEyG2IhnFtBszBHJTWs9LdupVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315026; c=relaxed/simple;
	bh=mtUKvDTsrjkePZ2g5xwnjWytCaVUXvFbCwliXsgaJ90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZvUMbP/mWGkQr4GQeJX/dRwADCppNreCYGYYLInXjADXtmAiZjpx63xRsmCvmJPDa7lUNqWDIiPDksK/xxOYX6BuCxfRXE+5Lb6wk+uoQJZoMYsAomCby2CSSscBwZ1nEIRzVmi831uw9XXZGy8SRgudkSakJhajfP51DqkpwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e/tr0o2M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52ABEC4CEF7;
	Tue, 17 Feb 2026 07:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771315026;
	bh=mtUKvDTsrjkePZ2g5xwnjWytCaVUXvFbCwliXsgaJ90=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e/tr0o2MWdyA/3shZ4c8uhVYLqAsPPD9MxaiBP+njJ76Y3PSzo+lrS843UdRRJkQp
	 MWVkfj2QdDcY/YH9ZVXnqeM1jC+cV/C+ptzDSezB8ufx+msxnaUSjMElMhUNQEdwTv
	 EJEJ+vznPJHBaGCB0TXWP3ICiPdNQl3Y+L/qBDGKWPkt/I0yIfe4RmvQF7r9a31ibU
	 1TK5o0l81CNbTTSFKqO21oTexF9A5jpCb+YX2ogbzLFA7yi6vqMWgN6SX0Yy7kwKM6
	 +s4vimh4Tj1C44BWH6G1mTs9z+K62mXwGSKJ/GBBWmt5YU7b79vG+6yuwFeh6LAl4V
	 ip25lHO0OkjOw==
Date: Tue, 17 Feb 2026 09:56:54 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Michael Margolin <mrgolin@amazon.com>,
	Gal Pressman <gal.pressman@linux.dev>,
	Yossi Leybovich <sleybo@amazon.com>,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Abhijit Gangurde <abhijit.gangurde@amd.com>,
	Allen Hubbe <allen.hubbe@amd.com>,
	Krzysztof Czurylo <krzysztof.czurylo@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Michal Kalderon <mkalderon@marvell.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Christian Benvenuti <benve@cisco.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH rdma-next 42/50] RDMA/bnxt_re: Complete CQ resize in a
 single step
Message-ID: <20260217075654.GI12989@unreal>
References: <20260213-refactor-umem-v1-0-f3be85847922@nvidia.com>
 <20260213-refactor-umem-v1-42-f3be85847922@nvidia.com>
 <CA+sbYW0Gh2bLoPZKzH9u-EcWDTz6mbF3RB=6Q3q=m7YpUpNU6Q@mail.gmail.com>
 <20260216080746.GD12989@unreal>
 <CA+sbYW0Ba==5Z5fyqjBS1AH8HE37ese2qMiR4+hoY-i8pajzQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW0Ba==5Z5fyqjBS1AH8HE37ese2qMiR4+hoY-i8pajzQg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8865-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[30];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ziepe.ca,broadcom.com,chelsio.com,amazon.com,linux.dev,linux.alibaba.com,huawei.com,hisilicon.com,amd.com,intel.com,microsoft.com,nvidia.com,marvell.com,cisco.com,cornelisnetworks.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0129149759
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 10:32:25AM +0530, Selvin Xavier wrote:
> On Mon, Feb 16, 2026 at 1:37 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, Feb 16, 2026 at 09:29:29AM +0530, Selvin Xavier wrote:
> > > On Fri, Feb 13, 2026 at 4:31 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > >
> > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > >
> > > > There is no need to defer the CQ resize operation, as it is intended to
> > > > be completed in one pass. The current bnxt_re_resize_cq() implementation
> > > > does not handle concurrent CQ resize requests, and this will be addressed
> > > > in the following patches.
> > > bnxt HW requires that the previous CQ memory be available with the HW until
> > > HW generates a cut off cqe on the CQ that is being destroyed. This is
> > > the reason for
> > > polling the completions in the user library after returning the
> > > resize_cq call. Once the polling
> > > thread sees the expected CQE, it will invoke the driver to free CQ
> > > memory.
> >
> > This flow is problematic. It requires the kernel to trust a user‑space
> > application, which is not acceptable. There is no guarantee that the
> > rdma-core implementation is correct or will invoke the interface properly.
> > Users can bypass rdma-core entirely and issue ioctls directly (syzkaller,
> > custom rdma-core variants, etc.), leading to umem leaks, races that overwrite
> > kernel memory, and access to fields that are now being modified. All of this
> > can occur silently and without any protections.
> >
> > > So ib_umem_release should wait. This patch doesn't guarantee that.
> >
> > The issue is that it was never guaranteed in the first place. It only appeared
> > to work under very controlled conditions.
> >
> > > Do you think if there is a better way to handle this requirement?
> >
> > You should wait for BNXT_RE_WC_TYPE_COFF in the kernel before returning
> > from resize_cq.
> The difficulty is that libbnxt_re  in rdma-core has the  queue  the
> consumer index used for completion lookup. The driver therefore has to
> use copy_from_user to read the queue memory and then check for
> BNXT_RE_WC_TYPE_COFF, along with the queue consumer index and the
> relevant validity flags. I’ll explore if we have a way to handle this
> and get back.

The thing is that you need to ensure that after libbnxt_re issued resize_cq command,
kernel won't require anything from user-space.

Can you cause to your HW to stop generate CQEs before resize_cq?

Thanks

