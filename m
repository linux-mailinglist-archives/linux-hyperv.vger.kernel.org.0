Return-Path: <linux-hyperv+bounces-11971-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Xxe6HvrcVWogugAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11971-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 08:53:46 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0660B751AB8
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 08:53:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mafphPzT;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11971-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11971-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 755553007880
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 06:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DAA3EAC75;
	Tue, 14 Jul 2026 06:53:43 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF33E7BCB;
	Tue, 14 Jul 2026 06:53:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784012023; cv=none; b=uPnkOSWychO9DRfQBSQM9ctlwZL0OyPfeKgP+pR2dgtgtbo5Az4Botf1Je2OLUWdYgd76BoAJT3rGndXqvUgQqOdLDMb3GzF1X6gS9e2TLKicHVvsxAS9PlCaIWAGiuxJjRmTUxlwT67AnjuXNhfSvMZnbvwH0cr+AcFyBi2SGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784012023; c=relaxed/simple;
	bh=lf+PgPuHo1j+SeFCM5FcURMjNi+6xQBgnQRCCauM8uc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AUE14pHTHhzAvRSEfy9ka2QNdiOpLnooKRWaCsfOEX0uWL5e5rAp5s/OmUcS56ZCKKYks7WtO1sdoTal9RzJ8OqfWwFL1bcOwGwycSp9/7IzhUZqWzHt8z3uXIamRqv1Jknkc3ypwBmTk1N7JFPxp37gkQipfSB6QwgzJkm7sMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mafphPzT; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C75B1F000E9;
	Tue, 14 Jul 2026 06:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784012022;
	bh=iFOa7eutRJIl+Ny7NNDXXjWWk5fN/ZsVaSr6Jex8aL8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mafphPzTIOh3EJ0cjPF5x0wTv43Up+X9QQvs1+o+NNb+dULdyxR5AI9vrxCRdFVNz
	 VwbTC/d8/OrPfsmfY3rpqNnZi4Y0orfQECUrEci94qJfl0nRRA18rejMXz99AJ71PU
	 RyJl+Y+XE8BFqslvzShs6TbpWkgjQyzc+RyA8cgs3tO967vmXfZxeRzBHEqXNjItD5
	 PsjafSL9G6e+PQSWlj5o8zcyEsVm7dssapNpMh5CcHgDm6qaolii++/WYBJWx3yZ14
	 QmeK8RP0QYMv+5dX6JFwxcVTJ/MCd7c28nqhY8u4b3YVYAjEIQczY4UJ/C2wRm4/RT
	 tRrCXBnlkZfJw==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Michael Margolin <mrgolin@amazon.com>, 
 Gal Pressman <gal.pressman@linux.dev>, Yossi Leybovich <sleybo@amazon.com>, 
 Cheng Xu <chengyou@linux.alibaba.com>, Kai Shen <kaishen@linux.alibaba.com>, 
 Chengchang Tang <tangchengchang@huawei.com>, 
 Junxian Huang <huangjunxian6@hisilicon.com>, 
 Tatyana Nikolova <tatyana.e.nikolova@intel.com>, 
 Long Li <longli@microsoft.com>, 
 Konstantin Taranov <kotaranov@microsoft.com>, 
 Yishai Hadas <yishaih@nvidia.com>, Michal Kalderon <mkalderon@marvell.com>, 
 Nelson Escobar <neescoba@cisco.com>, Satish Kharat <satishkh@cisco.com>, 
 Bernard Metzler <bernard.metzler@linux.dev>, 
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hyperv@vger.kernel.org
In-Reply-To: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
References: <20260713-fix-destroy-no-udata-v1-0-fcca2e34fd57@nvidia.com>
Subject: Re: (subset) [PATCH rdma-next 0/2] RDMA: Small batch of cleanups
Message-Id: <178401201923.6794.11952273321586348029.b4-ty@kernel.org>
Date: Tue, 14 Jul 2026 02:53:39 -0400
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-18f8f
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:mrgolin@amazon.com,m:gal.pressman@linux.dev,m:sleybo@amazon.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:tangchengchang@huawei.com,m:huangjunxian6@hisilicon.com,m:tatyana.e.nikolova@intel.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:yishaih@nvidia.com,m:mkalderon@marvell.com,m:neescoba@cisco.com,m:satishkh@cisco.com,m:bernard.metzler@linux.dev,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-11971-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0660B751AB8


On Mon, 13 Jul 2026 11:10:33 +0300, Leon Romanovsky wrote:
> This series contains two independent cleanups. One fixes the problematic placemen
>  of a newly introduced in-kernel API, which should be called at the beginning of
> destroy functions and not at the end. The other removes a redundant memset().
> 
> Thanks.
> 
> 
> [...]

Applied, thanks!

[2/2] RDMA: Remove redundant memset() from query_device callbacks
      https://git.kernel.org/rdma/rdma/c/eeb9697db6c16d

Best regards,
-- 
Leon Romanovsky <leon@kernel.org>


