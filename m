Return-Path: <linux-hyperv+bounces-10879-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K9OLyX9BGrxRAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10879-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 00:37:25 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E1B53B86C
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 00:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00A943019D07
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 22:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA7A38B146;
	Wed, 13 May 2026 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4NVFrGs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D7F37F8A8;
	Wed, 13 May 2026 22:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711529; cv=none; b=fRPpKeR8fdYiPQpmE0Mkqu9Wykeqiwzw6B+/PKuYPYxPWWWGUX+0q4mkuob/HyT/zkr6uIakP9Fnh3T8UCb7FR3wKUNb5e//ae4TkKSurNObUFIf6U0qyWO/1lXTsiMOx2wYfZghfRXs6ocOYYLGtEJruw4YyQSIPkWlIsVfjfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711529; c=relaxed/simple;
	bh=iFy6DyTK6bP2bzHFBlZ5Z6Lji7h6EOpHFC92IovV77E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhQzAzEKKJBaGKIuO2sL3gVZEoOHLLq12D80OrvZVEX44udXiJaRmoBGVeKzwLd8HbpsAhz0s0dhTQBahAYDopuQf9x4gog4cD4a6pJ79i9O20eTVMQsM5OczTXgrDjnofliuA6hyexZMSk0bmQPvO1W6TiHXSXOh836uwAoRP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4NVFrGs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B01FC19425;
	Wed, 13 May 2026 22:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778711529;
	bh=iFy6DyTK6bP2bzHFBlZ5Z6Lji7h6EOpHFC92IovV77E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4NVFrGs/s1WZW5Q2qbdlWc6hVF1PfSK8ydtSf2fkRWro8Ms/Xlt+dfLZBAwuo+J+
	 42tqJkknGI6zzJlJKHAYAuiJJuaa8x4OevegQ9ms/Zd7BHq/vIVE15D7rlw8ddoNNo
	 CK6Vm39M98AeCorbWjZoNzf1K1pnCXhK7l1U7ItDlWF9qYFeWECWBxsUNj0/cMOAuR
	 XONP6LbOlVfevmhwkjEIwm8gm+DCbdp3ACMqCopW4QHVeaeYUfzA+854dnholO5f+5
	 zDjyIyTw7kHJL5mtcT+qZQ9/NabEHq5j88yuI5D+5vvWyJJgcdGcXEqdBc8EgtUcqc
	 KLG7/Uda5MMoA==
Date: Wed, 13 May 2026 22:32:07 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"jfalempe@redhat.com" <jfalempe@redhat.com>,
	"drawat.floss@gmail.com" <drawat.floss@gmail.com>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"simona@ffwll.ch" <simona@ffwll.ch>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"ryasuoka@redhat.com" <ryasuoka@redhat.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: Provide option to skip VMBus
 unload on panic
Message-ID: <20260513223207.GA336053@liuwe-devbox-debian-v2.local>
References: <20260217182335.265585-1-mhklkml@zohomail.com>
 <SN6PR02MB415786A3C7D10C22FAB12E3ED4312@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415786A3C7D10C22FAB12E3ED4312@SN6PR02MB4157.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 76E1B53B86C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[zohomail.com:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10879-lists,linux-hyperv=lfdr.de];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_CC(0.00)[kernel.org,suse.de,microsoft.com,redhat.com,gmail.com,linux.intel.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.802];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,zohomail.com:email,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Action: no action

On Mon, May 04, 2026 at 08:47:50PM +0000, Michael Kelley wrote:
> From: Michael Kelley <mhklkml@zohomail.com> Sent: Tuesday, February 17, 2026 10:24 AM
> > 
> 
> Wei and Thomas --
> 
> This small patch series has been neglected. Patch 2 of the series is here [1].
> 
> Long Li < longli@microsoft.com> has given a Reviewed-by on this patch,
> and Jocelyn Falempe <jfalempe@redhat.com> has given a Reviewed-by
> on Patch 2 of the series, modulo a comment which I have incorporated.
> See [2]. But I neglected to add her R-b when I spun v2 of the series.
> 
> Any reason this can't be picked up as a bug fix for 7.1? I just checked,
> and it applies cleanly to a recent linux-next (20260423). I'd suggest
> going through the hyperv tree, as these two patches should be kept
> together in sequence.
> 

I thought they were not reviewed yet. I have now applied them to hyperv-fixes.

Thanks for the reminder.

Wei

