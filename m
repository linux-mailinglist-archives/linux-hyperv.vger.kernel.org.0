Return-Path: <linux-hyperv+bounces-7060-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89609BB575D
	for <lists+linux-hyperv@lfdr.de>; Thu, 02 Oct 2025 23:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14F4D4E307E
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Oct 2025 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6901DE3B5;
	Thu,  2 Oct 2025 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CdJGD/CQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A572F18FC80;
	Thu,  2 Oct 2025 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440110; cv=none; b=ZlJLFFGoL8YuQl83S/CPpZkHgio/9jVrZtuGUK9XOyMmExLmdUPr7yv/KqI2l15s1K4p1UIv15BpsaatZ8WGKnH3Axf4XvhCbqn/PJkq6ElFzdC9lbekc8sqlq5/LvQl2o15Sl7uDyIK5V219AmZ0D9dld/rBy52K6Q/mMftr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440110; c=relaxed/simple;
	bh=cq3l9uvZgAZ0zo7SP0JihNtM1tzlAkisHcbMDaHuGYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YwWqanYaFG9L5ic24q8ImMPEM8ZJJ7xYUAjnI6jOzhVWzm0fNEk53VUIQIoBgtcViGNCOfnJ4cBblmJXDBuLQV2RKM7Pe+eqAgj5KHfKffuPzPltLSPFkFka+XNu2mRl+x3+J+vUstDYRhIz0PG9xXmPLkYdjL1P4Yvyk6PSdb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CdJGD/CQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD07C4CEF4;
	Thu,  2 Oct 2025 21:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759440110;
	bh=cq3l9uvZgAZ0zo7SP0JihNtM1tzlAkisHcbMDaHuGYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CdJGD/CQDOjjAOvEVRtShzv0XG7zvtQN5RZu0K+odUuoTF0Yzp7x2Bm9+WNLFfXic
	 WIB3f3b/yIhbgi4tcA+TE91W95w7WpjNX7UF/vLYEJfsEnEXpikggYpF7wRMzWyeZl
	 qgS1KodEAMBmxi66jtozbclm/ac5uRULDiK13w1rkVC1Q1gXrm+PiKlf07TvnSZYZ+
	 HnoXy/musw6+kzP1ID2O0vNP+36wGO0A49yc5F7fUqaEwt+sOExrc2pRs+TESgzyX1
	 fhl7UG9G0MNf7p/U7v7f4+xJT0Yxyy8V8mU3jz/Q1Z3Cn7gJyg0n2j8Eu+KKvlpc34
	 S9EfT5B/Johzw==
Date: Thu, 2 Oct 2025 21:21:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: Roman Kisel <romank@linux.microsoft.com>, decui@microsoft.com,
	eahariha@linux.microsoft.com, haiyangz@microsoft.com,
	kys@microsoft.com, mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	benhill@microsoft.com, bperkins@microsoft.com,
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next] hyperv: Remove the spurious null directive
 line
Message-ID: <20251002212148.GB925245@liuwe-devbox-debian-v2.local>
References: <20251001230847.5002-1-romank@linux.microsoft.com>
 <089d6be9-20be-4985-a761-51bfb9879b92@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <089d6be9-20be-4985-a761-51bfb9879b92@linux.microsoft.com>

On Thu, Oct 02, 2025 at 09:04:21AM -0700, Easwar Hariharan wrote:
> On 10/1/2025 4:08 PM, Roman Kisel wrote:
> > The file contains a line that consists of the lone # symbol
> > followed by a newline. While that is a valid syntax as
> > defined by the C99+ grammar (6.10.7 "Null directive"), it
> > serves no apparent purpose in this case.
> > 
> > Remove the null preprocessor directive. No functional changes.
> > 
> > Fixes: e68bda71a238 ("hyperv: Add new Hyper-V headers in include/hyperv")
> > Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> > ---
> >  include/hyperv/hvgdk_mini.h | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
> > index 1be7f6a02304..77abddfc750e 100644
> > --- a/include/hyperv/hvgdk_mini.h
> > +++ b/include/hyperv/hvgdk_mini.h
> > @@ -597,8 +597,6 @@ struct ms_hyperv_tsc_page {	 /* HV_REFERENCE_TSC_PAGE */
> >  #define HV_SYNIC_SINT_AUTO_EOI		(1ULL << 17)
> >  #define HV_SYNIC_SINT_VECTOR_MASK	(0xFF)
> >  
> > -#
> > -
> >  /* Hyper-V defined statically assigned SINTs */
> >  #define HV_SYNIC_INTERCEPTION_SINT_INDEX 0x00000000
> >  #define HV_SYNIC_IOMMU_FAULT_SINT_INDEX  0x00000001
> > 
> > base-commit: e3ec97c3abaf2fb68cc755cae3229288696b9f3d
> 
> Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

Applied.

