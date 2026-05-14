Return-Path: <linux-hyperv+bounces-10886-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qCywNE6GBWr5XwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10886-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 10:22:38 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 355EE53F36B
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 10:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CA530107D7
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 08:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100073B52E9;
	Thu, 14 May 2026 08:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gl/oGPOj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E119930BF4E;
	Thu, 14 May 2026 08:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778746956; cv=none; b=oRFQatdMHyPljz1AC7LY4KjsNT7tDijQCvaWIDbjifYuYxNP+/xyCraD9UOzkYtqWHwbwGFb4epgAs0WaEwiE5kLrIhSA3Ppd2rTqCaYamAWZzw5O0fw2iFWZoZc2gigfAdjfULYkszS41tcGA7+nmAxaQJLJB+4z+upva4yNA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778746956; c=relaxed/simple;
	bh=2UpAkn85iCFOfo3+WoobARHiOyNXGU4+b2GxIRkaQFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=t09pDJ4fMe9X1PYxjTB7uJF88nWfusf95wXdpExjyrjo1RmXSEokordiIGEc3OJI0+XJi5T18+BhsJPxSJlgWLgr0TmpSQBBCAEXWNXVBDAWIokWKdlE9VJSXjT1I+8tSqPQ1tIVRgLgbnuOO9znSSJTLNNYyX/nDzZUSUf3zzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gl/oGPOj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC959C2BCB7;
	Thu, 14 May 2026 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778746955;
	bh=2UpAkn85iCFOfo3+WoobARHiOyNXGU4+b2GxIRkaQFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gl/oGPOjlOH2/EKeFC7L6yacqR+ueKD4l755F7cdxw5kIkKATxXfg0dQvQrm8+oBJ
	 gG6jc8YoPOc70iJlG8ZqaphoEUbtieCutxubGOc5L5btfsnEvQmJ8+vEUnNl14yJ4f
	 X1L4vRvG7bmQBa3AcbxnCNIscfce080XV4FMiMDMWQbpztJSdnMO4PvQSBH81XJmp/
	 DsnxJ5RIqP9PKuepcHV+71DFD3tCYJFxQ0RzQtfT6KFkdE8rGgtpKG4hxYM7wgQkik
	 bXPEme+rrstL8+kF05sSD5okFZi9jrsM3iAc//+6OUg6NjmVQB0991fvWyQSzuuxGo
	 mR8W7Rlc5b/+A==
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>, 
 Allen Hubbe <allen.hubbe@amd.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bernard Metzler <bernard.metzler@linux.dev>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Cheng Xu <chengyou@linux.alibaba.com>, 
 Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, 
 Gal Pressman <gal.pressman@linux.dev>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, 
 Kai Shen <kaishen@linux.alibaba.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, 
 Krzysztof Czurylo <krzysztof.czurylo@intel.com>, 
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org, 
 Long Li <longli@microsoft.com>, Michal Kalderon <mkalderon@marvell.com>, 
 Michael Margolin <mrgolin@amazon.com>, Nelson Escobar <neescoba@cisco.com>, 
 Satish Kharat <satishkh@cisco.com>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Yossi Leybovich <sleybo@amazon.com>, 
 Chengchang Tang <tangchengchang@huawei.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, Yishai Hadas <yishaih@nvidia.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: patches@lists.linux.dev
In-Reply-To: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
References: <0-v3-4effdebad75a+e1-rdma_udata_rep_jgg@nvidia.com>
Subject: Re: [PATCH v3 00/10] Convert all drivers to the new udata response
 flow
Message-Id: <177874695251.2400877.15097809543783345689.b4-ty@kernel.org>
Date: Thu, 14 May 2026 04:22:32 -0400
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Queue-Id: 355EE53F36B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10886-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action


On Mon, 11 May 2026 21:09:29 -0300, Jason Gunthorpe wrote:
> Go through the drivers and migrate them to use ib_respond_udata(). Remove
> debugging prints on failure paths.  Ensure the error propagates from
> ib_respond_udata(). Use the = {} pattern to initialize the uresp.
> 
> There are a couple of oddball cases which are fixed up in their own
> commits, but otherwise this is fairly straightforward.
> 
> [...]

Applied, thanks!

[01/10] RDMA: Use ib_is_udata_in_empty() for places calling ib_is_udata_cleared()
        https://git.kernel.org/rdma/rdma/c/41480529abf89b
[02/10] IB/rdmavt: Don't abuse udata and ib_respond_udata()
        https://git.kernel.org/rdma/rdma/c/34705a1ae3e700
[03/10] RDMA: Convert drivers using min to ib_respond_udata()
        https://git.kernel.org/rdma/rdma/c/0d1e825104e8bd
[04/10] RDMA: Convert drivers using sizeof() to ib_respond_udata()
        https://git.kernel.org/rdma/rdma/c/051ac78d04654f
[05/10] RDMA/cxgb4: Convert to ib_respond_udata()
        https://git.kernel.org/rdma/rdma/c/07a642d0284c48
[06/10] RDMA/qedr: Replace qedr_ib_copy_to_udata() with ib_respond_udata()
        https://git.kernel.org/rdma/rdma/c/17bf245156ac71
[07/10] RDMA/mlx: Replace response_len with ib_respond_udata()
        https://git.kernel.org/rdma/rdma/c/f2d022ef99ec62
[08/10] RDMA: Use proper driver data response structs instead of open coding
        https://git.kernel.org/rdma/rdma/c/d06310eda43097
[09/10] RDMA: Add missed = {} initialization to uresp structs
        https://git.kernel.org/rdma/rdma/c/b0e60caf6c9d0c
[10/10] RDMA: Replace memset with = {} pattern for ib_respond_udata()
        https://git.kernel.org/rdma/rdma/c/be4bca92cb86a6

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


