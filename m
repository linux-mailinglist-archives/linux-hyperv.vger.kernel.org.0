Return-Path: <linux-hyperv+bounces-1777-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAF287EFEE
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 19:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F1BF28388E
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Mar 2024 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF3438DD3;
	Mon, 18 Mar 2024 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aaJ63qZ9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504152837D;
	Mon, 18 Mar 2024 18:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710787544; cv=none; b=RR4Ll32VQjFWF+rWVtx6cU3jm1vTqjVDW2o5DIMFCC8EQ2SJ32pcI1Y6sLOBODh6YWQS/P0UD+6TIPqgDMgwvh980v/MBIZfaGMNa7Dy1MHfSw6LSqCstzhOiTZMOMgrSwG8oRg7TVU9qKjQmFYQ0+oOEgaY9NdPVKIfDk7V0wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710787544; c=relaxed/simple;
	bh=OYAKlIUSYWWb3PfM506o9FNEVaO34KNtnV3BREnAS3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1nz0/sJ2GEQmJ6I286ZsT/9+tsjKpAwv343DKl8taaoHse48YN2ttfsuSTPkUTNcA1S/PJvV/hZ4M8yL2aO5x7PiQqJKDBbAiRHjxcrLhpWksH1m+jXsPnTOaYcoEEhcQPI7ErvXswfzJraC+0UimoH5x2uuqTJIaNvjmgCzeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aaJ63qZ9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id DCC6820B74C0; Mon, 18 Mar 2024 11:45:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DCC6820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1710787542;
	bh=2qDWxZlMr9OLeQtZl1hDoIzYJ0fyvUJXJtEfjRIAd6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aaJ63qZ9Qj0NDj6IkQRlaHtnDzcyulfmG6D8gQ82Dh1gKac9QtONxdbGBGUTR46Iv
	 X7lYxlXNDc1HUX+BiVgGR1c4vW/dbR/wibdHx/OoODZyIybQEZEldu/jMEKmzkBs8R
	 FGo377nsmwC+LoCksIsh2na3/bnxGGIT6BzulZ8Q=
Date: Mon, 18 Mar 2024 11:45:42 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Olaf Hering <olaf@aepfle.de>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination
 for keyfile format
Message-ID: <20240318184542.GA9011@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710729951-2695-1-git-send-email-shradhagupta@linux.microsoft.com>
 <9d24633d-b2bf-4cbe-86f7-6df56ba14657@linux.microsoft.com>
 <C740F1C4-CA2A-425B-8E60-0EF5C2C15270@redhat.com>
 <066c4b0c-c8a5-4abd-9456-20b0352ee1ab@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <066c4b0c-c8a5-4abd-9456-20b0352ee1ab@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 18, 2024 at 10:16:59AM -0700, Easwar Hariharan wrote:
> On 3/18/2024 10:12 AM, Ani Sinha wrote:
> > 
> > 
> <snip>
> 
> >>> + }
> >>> +
> >>> + if (strlen(output_str)) {
> >>> + output_str[strlen(output_str) - 1] = '\0';
> >>
> >> You don't need this since you're using strncat which adds its own '\0'.
> > 
> > If I understand this correctly, this code simply eliminates the extra ???,??? character in the end. Therefore it is needed.
> > Since it is not obvious, in the previous review and before, I asked the author to add a comment to explain this clearly.
> > 
> >> I wasn't quite able to follow along 
> >> on the discussion between Ani and you, so putting this in here in case it wasn't already mentioned.
> >>
> 
> Ah, great, that makes sense. I did see that it was destroying data but didn't spend enough time to think through
> what data it was destroying, and if that was a feature or a bug. Thanks for calling it out!
> 
> - Easwar
> 
>
Thanks Ani, Easwar for all the comments. Apologies for not addressing some of the comments from the previous
version's review. For some reason my editor did not highlight it as expected. I will get them all with a new
version. Thanks. 

