Return-Path: <linux-hyperv+bounces-10309-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFVnGwRq6GlZKAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10309-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 08:26:12 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFC044263E
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 08:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DF81130058C6
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 06:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712D2D060B;
	Wed, 22 Apr 2026 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr65nNMJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083C2C0307;
	Wed, 22 Apr 2026 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839160; cv=none; b=qU2gcIxKzWQFgg6HDSxbBox843XsdvbrgZU/GLO6Oxct+6zwc7Y40kayx19U1htXZQB0tZFWrt5jest3wcRKd/DzXtnCPjy/l2wJrGTAnLz2QwPYt7S2z7kjAGqPFnadIwo4MkYnG1WakoKgkn19EcbE3olKZ0hlkLFrsKeN9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839160; c=relaxed/simple;
	bh=UIsS48hwkwg+vaA44Sv+PQoDF9ZlSMsJ/DpD9VqJkls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOfRqewLbPtQvRCD0Dr7i70TZoY+nCkTlsJcijeDmwPFYkHVwv7RYneuNyYp+cQJ87QkuDjx3GOcSnojCx0UtnEGaLSXNJM/O13BXSDHcbMz3YcIs366xD44siAF78iWoowD0R17wu8cBkKlU6GuJRgzQ+isH5Xez+qj3x0gcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr65nNMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337B6C19425;
	Wed, 22 Apr 2026 06:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776839160;
	bh=UIsS48hwkwg+vaA44Sv+PQoDF9ZlSMsJ/DpD9VqJkls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cr65nNMJp+WO44DD8fCyb6bZDLb50nC8eX6SskEAGCfWwnByhYd/P5RZNSxIWzwdD
	 xSIgSrx/t+riZjgWh2X9bUS3Y5b3D/yiYxMLKQkX3N6j30F44dJLRuTnh6Bik6c/R2
	 i2akW4NnC/ZuTFbFsV2wu2xczIGqLGZKbULmOFxIwnyvoEA71brXvq56ATyb/p3+kA
	 9cpiB57BDW26s6byTlfuQgvA8pZkLcj4FSYOt4WpntuE+4zcH776ILLGPaH/azYBSu
	 UOF8QgsiwCBkqQnkLGV1Qd1HDGxQa5d18B/ZC8iUs3Ua8DaXlAb09Fe+SACq0tpEfw
	 JTA5m9771a6IQ==
Date: Wed, 22 Apr 2026 06:25:58 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Fix incorrect access type usage in GPA intercept
 trace event
Message-ID: <20260422062558.GA805420@liuwe-devbox-debian-v2.local>
References: <177682681331.1683870.15540242284121796900.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177682681331.1683870.15540242284121796900.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10309-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 0FFC044263E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 03:00:13AM +0000, Stanislav Kinsburskii wrote:
> The trace event was checking for HV_INTERCEPT_ACCESS_READ twice in the
> ternary operator chain instead of checking for EXECUTE, which would
> cause execute accesses to be incorrectly displayed as '?' in traces.
> 
> Move the access type conversion to the TP_fast_assign section where
> the raw value is available, rather than performing the conversion
> during formatting. This eliminates the redundant checks and ensures
> all access types are correctly identified and displayed.
> 
> Fixes: 03f7d01f699010 ("mshv: Add tracepoint for GPA intercept handling")

This is not yet in Linus' tree.

I folded this into the original patch.

Wei

> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_trace.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_trace.h b/drivers/hv/mshv_trace.h
> index 6b8fa477fa3bf..e7280c47e579a 100644
> --- a/drivers/hv/mshv_trace.h
> +++ b/drivers/hv/mshv_trace.h
> @@ -524,16 +524,16 @@ TRACE_EVENT(mshv_handle_gpa_intercept,
>  		    __entry->partition_id = partition_id;
>  		    __entry->vp_index = vp_index;
>  		    __entry->gfn = gfn;
> -		    __entry->access_type = access_type;
> +		    __entry->access_type = access_type == HV_INTERCEPT_ACCESS_READ ? 'R' :
> +					   (access_type == HV_INTERCEPT_ACCESS_WRITE ? 'W' :
> +					    (access_type == HV_INTERCEPT_ACCESS_EXECUTE ? 'X' : '?'));
>  		    __entry->handled = handled;
>  	    ),
>  	    TP_printk("partition_id=%llu vp_index=%u gfn=0x%llx access_type=%c handled=%d",
>  		    __entry->partition_id,
>  		    __entry->vp_index,
>  		    __entry->gfn,
> -		    __entry->access_type == HV_INTERCEPT_ACCESS_READ ? 'R' :
> -				    (__entry->access_type == HV_INTERCEPT_ACCESS_WRITE ? 'W' :
> -				    (__entry->access_type == HV_INTERCEPT_ACCESS_READ ? 'X' : '?')),
> +		    __entry->access_type,
>  		    __entry->handled
>  	    )
>  );
> 
> 

