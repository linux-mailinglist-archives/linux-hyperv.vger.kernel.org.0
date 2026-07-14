Return-Path: <linux-hyperv+bounces-11969-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kGwfNUeuVWqergAAu9opvQ
	(envelope-from <linux-hyperv+bounces-11969-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 05:34:31 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7801A750AAB
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 05:34:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.microsoft.com header.s=default header.b=TEQ4mSyc;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11969-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11969-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.microsoft.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 793B1302FB43
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Jul 2026 03:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE02A35675E;
	Tue, 14 Jul 2026 03:34:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC318DB1A;
	Tue, 14 Jul 2026 03:34:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784000065; cv=none; b=iQgpuwSEqnLftCV8h+wIQOoM8MXVh3eURzWkrmwSKuz5YPf2ND0Q4ER20WvFlQT9ABNMVUgTdhEHLetK+F7Df3f3vSrA6eAMAJHJ52BoyFEIAyf07odPOSuAALvSEiF7M12gmrS/nWIUiXmcCdZRouLvFBjAinxahDpyq64008k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784000065; c=relaxed/simple;
	bh=B6QjqsTCceglXTjrdbHmu3Fd6hA0gffWs3PjsBDdmhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP8lhThu65SIpBwAzbAsBC840VjOxCI3amkdIcC/K3C2bOywZPsvc0AvY56CSwhAOI2KPoMf2zbXqBRUJ5PO9osUzUoG0TD61UWISmBjG/5YFf3noF6QZTrOw+tSwdEhzhL37xiJ+qo9CwvapoK9HVnWDFUq2Rr/H+Flayv700g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TEQ4mSyc; arc=none smtp.client-ip=13.77.154.182
Received: from localhost (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 57B3D20B7166;
	Mon, 13 Jul 2026 20:34:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57B3D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784000055;
	bh=KAZQv62H0azYxiU1DuGKBqf//wlcUoJu/KF5uIUpZhI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TEQ4mSycKUDcvlPTFdFVgJOwUO52dEvB5haGH+yL3kfCTyhw2CV0/cGTmkH25mNW9
	 NPg3Th2kOLW0HTUfobsvEIptk3eR4uUi93bOkQgPGgKIafD5dRPYUsE0qyWVN8jB4s
	 cJS0DeK2mHrYyaMpEzppezoGVATrnK1mC4UF+3Ag=
Date: Tue, 14 Jul 2026 11:34:21 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, 
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>, 
	"longli@microsoft.com" <longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com" <tgopinath@linux.microsoft.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>
Subject: Re: [PATCH v2 3/4] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <r35cz2l3yz2wyi5d663mxwqoiz2rrl6kzpiw6rsruh7ofk6vu6@temnhcfsp6fa>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-4-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157253E030D477FD91B7E26D4FE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <enpkphavwmqrkded73c43vprczslvei4755lkxuedof4z2k3kk@y2jtklbk4efz>
 <SN6PR02MB4157805F23ACA85A668FA065D4FC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <3ty6yq6oftsvq52skrngjv5xpyixhsyfo3dndhoujt7emxsb2o@y6ischifpmfn>
 <SN6PR02MB41575E067DFEBEACF316CD35D4FA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41575E067DFEBEACF316CD35D4FA2@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[microsoft.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:mhklinux@outlook.com,m:linux-kernel@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:iommu@lists.linux.dev,m:linux-pci@vger.kernel.org,m:linux-arch@vger.kernel.org,m:wei.liu@kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,m:joro@8bytes.org,m:will@kernel.org,m:robin.murphy@arm.com,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:lpieralisi@kernel.org,m:mani@kernel.org,m:robh@kernel.org,m:arnd@arndb.de,m:jgg@ziepe.ca,m:jacob.pan@linux.microsoft.com,m:tgopinath@linux.microsoft.com,m:easwar.hariharan@linux.microsoft.com,m:mrathor@linux.microsoft.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[outlook.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11969-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangyu1@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7801A750AAB

On Mon, Jul 13, 2026 at 05:37:51PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, July 13, 2026 9:46 AM
> > 
> > On Sat, Jul 11, 2026 at 06:31:15PM +0000, Michael Kelley wrote:
> > > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Friday, July 10, 2026 12:34 AM
> 
> [snip]
> 
> > >
> > > One new thought:  Have you considered the hibernate/resume
> > > cycle? Does anything need to be done with the pvIOMMU to
> > > make it functional again after resume? I see that the Intel and
> > > AMD IOMMU drivers have suspend and resume functions. I
> > > don't know enough about the Hyper-V pvIOMMU to know if it
> > > might also need suspend and resume functions.
> > >
> > 
> > Thanks for raising this, Michael. We have not considered such support.
> > 
> > My understanding is that the Intel and AMD drivers only disable the
> > IOMMU translation, flush the IOTLB during the suspend and re-enable/
> > reload the preserved root tables and other HW state during in the
> > resueme.
> > 
> > But for pvIOMMU, I guess such job shall be done by the hypervisor?
> > For a device resumed on the same VM, its logical device ID should
> > also remain unchanged?  And the corresponding Hyper-V domain objects,
> > configuration, and device attachments shall be preserved and restored
> > by hypervisor? I don't think the current Hyper-V ABI explicitly defines
> > this. But maybe if we want such feature, it could be done by the
> > hypervisor transparently?
> > 
> 
> I agree with your and Jacob's comments that the guest doesn't have
> any responsibility for saving/restoring IOMMU hardware state, as the
> Intel and AMD IOMMU drivers do.
> 
> But yes, I'm wondering about the Hyper-V domain objects and device
> attachments. I doubt Hyper-V can do anything to save and restore
> them. Hibernation is a Linux concept that the Hyper-V host doesn't
> know anything about.
> 
> Hibernation is already complicated, and in a VM it is even worse. :-(
> As a start, see Documentation/virt/hyperv/hibernation.rst, which I
> wrote about 18 months ago. It provides some basics as well as outlines
> the additional complexity in a Hyper-V guest VM. I'll also try to spend
> some time thinking through the implications for a pvIOMMU, and let
> you know if I have any more thoughts.
> 

Thank you, Michael, and thanks for pointing us to the documentation. I
need some time to better understand the Linux guest hibernation and resume
flow and its implications for pvIOMMU.

Meanwhile, do you think this limitation should be documented in the
commit message or the cover letter?

B.R.
Yu

> Michael

