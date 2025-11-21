Return-Path: <linux-hyperv+bounces-7745-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E25C790B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 673884E79F0
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 12:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440DE313270;
	Fri, 21 Nov 2025 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dia9WHg7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7F52D8379
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763728989; cv=none; b=UOf4HJAHQmW1EPgLmykYpShHFDNrYELIRKc8FUdZGT+ePPtwLJu7pbhc/2mOnhn6zTtVnnDEoG2IsKaN6gYTSJZkKI8QYkKQdNiO0Sxv7zMpPliDGfzwetfsa2/nhEOuSYlwMstUJf6Lg7T0EkYgs7Cu0hodmk8PYCa/A66Xtdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763728989; c=relaxed/simple;
	bh=5+mUUCMR3SZoijvRg46BOPKnSb+b0dNPblN10Nfx8kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+rAItB1hch1AqvB16QvqyZNxExCr5jIgTe8V/4s+eOF4BW5fXgkvZoRGlY7iTEOP+XbcfMBQqqZ3y2uRxwTjr8qkno+NVOqU/3/aGWNzr/orJnarDLnNQS459fhwtAYT3gJ8HD136kxY7YUZNNMhPF4ARGe3/pRZmeVnxypZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dia9WHg7; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42bb288c219so1838597f8f.1
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 04:43:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763728985; x=1764333785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2zCvNqGgtbT+DYiS8F37VDn4ftbMHGNVSrKqGSwmzU=;
        b=Dia9WHg7lxDgb1w2BasYx27dgy1rV+82Oh+GAss90th+dxbZXVYTRKmCODrtRbvkFo
         /oeUl9fPwRUAene68NdY3+FtURo5aJPOtkyALTkBjKjuFBq0iduNZuDkkyN0xpwzTLtK
         X9rbnjZHbDwOSgE8RyhLyVkQD/Q3lYhV6fNdHjwJykvA6Ir55ZYc8eJDwwAQmAEz5s7J
         Pb9Vkrj/RRUgUBO1fF7bCMjrO5P6Z3XJCxuw6cevI7SvSGsrV1OZGwREiumnzHBwlxJA
         HGdw/FfwpD+OzQTxOwZBUPLsl0GojkuBdct774REg3WMpq4r1GG6enWlacro05Xkb60Z
         XQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763728985; x=1764333785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p2zCvNqGgtbT+DYiS8F37VDn4ftbMHGNVSrKqGSwmzU=;
        b=WqYaWaE/ju7axbTPJfJWWHdjsGROSoKZZDmCBVyH1b0wDpnYV8WxpIK+WntnmU08QD
         ubi/MZLOzEJS89+5UH13eJo2ITcIdiE+0e2QJxWZJb483xUDckBpw+5gV4gocfzg3Nom
         Jwm2Rqasq3H32iwwHLwsKOWcai6Z1YblZbNjCOBqwXRUG9US3qfJ1YH8G2f7WuyCxbGn
         fsakgynXgbBp0O+MOrdQaJhjFg174kPHjlVDz27+I7pCzmSNgeUlaLpDMJxWq/l036ei
         gx8idQOmAEmadE7/DKeDZ5wciL9KeOjxzMD+/cp+4NuniVfSRIMfI9IrDQGriT/6N70u
         3MGw==
X-Forwarded-Encrypted: i=1; AJvYcCXxbhPrvdkR5Ix0xl1FBocz27EtFRwymc8ITei8SiNoPfMXcRRBcMlbQTW5JXBGAViPGBizJRpInnh0MkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCtRb7+w3e+BLJTwsfS/TCx3tUL6Q4GUFm48ixRRWW1P6gOgLL
	9BKCnFBUHl1TxzCpG0bJxqiGylHBZ0/IUEiD0xmwZT/0r0srSDgt41sX
X-Gm-Gg: ASbGncsA3IOrDFXxdghGSADU3Vo6UsBgE1Ekz89lL5fuk81BhS4LBowXUuKfXYxYY+7
	Pf0NtVqSMNO19XXPKYsaEokqKzZpAFKKy8zoR5Z8q9cAznXhp7us/av5Hx5OLi1angfAqVSIj2R
	O8rCWnjgkgX7cS+Thm5z/vzzeYFdf+RfEj3g5ra9HcGU0xGbaZCeAkEA7a1M9BrpzBVNg6ViGHP
	u5SM4bMszDvsWkjoeaVvE6+IrUBGkKYpKJf5K+NwajMWY1KKePSuUVRMh61Q4qXEKh6pgqwLy5A
	w2oJZ0v0ZLi/boBJuzAYmkri2pxiW+d4gSjIXDg/0awBgiTfaakLpz+hpDX2NMF7qJFYGgmRtxO
	pqO6uqm+xxLtQ9FD4KPyVtQWpgvULzpRaHKKXMgJ/Ji5dpjqWbyGV3jv4xy9/Ya4zLx7DMn4pXl
	GMXS9cQ8Xzy878cGRopD6RFy5+wmHjcsOppe7Zfrdcotcz
X-Google-Smtp-Source: AGHT+IEYyrnMjnQzt45RXJSTndXYbiIKdxOV3PNbGbGzl7In1RJUbl41mOUpIYSKX5evZrviAlviFw==
X-Received: by 2002:a05:6000:230f:b0:42b:4223:e62a with SMTP id ffacd0b85a97d-42cc1cbe219mr2220762f8f.23.1763728984741;
        Fri, 21 Nov 2025 04:43:04 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f2e556sm10734719f8f.5.2025.11.21.04.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:43:04 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 673ADBE2EE7; Fri, 21 Nov 2025 13:43:03 +0100 (CET)
Date: Fri, 21 Nov 2025 13:43:03 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naman Jain <namjain@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Peter Morrow <pdmorrow@gmail.com>
Subject: Re: [PATCH 6.6 and older] uio_hv_generic: Enable user space to
 manage interrupt_mask for subchannels
Message-ID: <aSBeVyYD2HQ5zNbC@eldamar.lan>
References: <20251115085937.2237-1-namjain@linux.microsoft.com>
 <2025112109-legroom-resend-643f@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025112109-legroom-resend-643f@gregkh>

Hi,

On Fri, Nov 21, 2025 at 11:10:43AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Nov 15, 2025 at 02:29:37PM +0530, Naman Jain wrote:
> > From: Long Li <longli@microsoft.com>
> > 
> > Enable the user space to manage interrupt_mask for subchannels through
> > irqcontrol interface for uio device. Also remove the memory barrier
> > when monitor bit is enabled as it is not necessary.
> > 
> > This is a backport of the upstream commit
> > d062463edf17 ("uio_hv_generic: Set event for all channels on the device")
> > with some modifications to resolve merge conflicts and take care of
> > missing support for slow devices on older kernels.
> > Original change was not a fix, but it needs to be backported to fix a
> > NULL pointer crash resulting from missing interrupt mask setting.
> > 
> > Commit 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
> > removed the default setting of interrupt_mask for channels (including
> > subchannels) in the uio_hv_generic driver, as it relies on the user space
> > to take care of managing it. This approach works fine when user space
> > can control this setting using the irqcontrol interface provided for uio
> > devices. Support for setting the interrupt mask through this interface for
> > subchannels came only after commit d062463edf17 ("uio_hv_generic: Set event
> > for all channels on the device"). On older kernels, this change is not
> > present. With uio_hv_generic no longer setting the interrupt_mask, and
> > userspace not having the capability to set it, it remains unset,
> > and interrupts can come for the subchannels, which can result in a crash
> > in hv_uio_channel_cb. Backport the change to older kernels, where this
> > change was not present, to allow userspace to set the interrupt mask
> > properly for subchannels. Additionally, this patch also adds certain
> > checks for primary vs subchannels in the hv_uio_channel_cb, which can
> > gracefully handle these two cases and prevent the NULL pointer crashes.
> > 
> > Signed-off-by: Long Li <longli@microsoft.com>
> > Fixes: 37bd91f22794 ("uio_hv_generic: Let userspace take care of interrupt mask")
> 
> This is a 6.12.y commit id, so a fix for 6.6.y does not make sense :(

Should maybe be updated to reflect the original upstream commit. In
fact b15b7d2a1b09 ("uio_hv_generic: Let userspace take care of
interrupt mask") was backported to various stable series:

v5.4.301: 540aac117eaea5723cef5e4cbf3035c4ac654d92 uio_hv_generic: Let userspace take care of interrupt mask
v5.10.246: 65d40acd911c7011745cbbd2aaac34eb5266d11e uio_hv_generic: Let userspace take care of interrupt mask
v5.15.195: a44f61f878f32071d6378e8dd7c2d47f9490c8f7 uio_hv_generic: Let userspace take care of interrupt mask
v6.1.156: 01ce972e6f9974a7c76943bcb7e93746917db83a uio_hv_generic: Let userspace take care of interrupt mask
v6.6.112: 2af39ab5e6dc46b835a52e80a22d0cad430985e3 uio_hv_generic: Let userspace take care of interrupt mask
v6.12.53: 37bd91f22794dc05436130d6983302cb90ecfe7e uio_hv_generic: Let userspace take care of interrupt mask
v6.17.3: e29587c07537929684faa365027f4b0d87521e1b uio_hv_generic: Let userspace take care of interrupt mask

And Peter just confirmed in
https://lore.kernel.org/stable/CAFcZKTyOcDqDJRB4sgN7Q-dabBU0eg7KKs=yBJhB=CNDyy7scQ@mail.gmail.com/
that he is seeing the problem now as well after updating from
6.1.153-1 to 6.1.158-1 in Debian.

> > Closes: https://bugs.debian.org/1120602
> > Cc: <stable@vger.kernel.org> # 6.6.x and older
> 
> How "old" do you want this?  Can you fix the Fixes: line up and resend
> with this info?

It is at least relevant for back in 6.1.y now, but I'm not sure about
the older series. I will let Naman speak up.

I guess the proper fixes tracking is a bit "tricky" because it only
affected some of the stable series, namely those which had a backport
of b15b7d2a1b09 ("uio_hv_generic: Let userspace take care of interrupt
mask") done before the including a backport of d062463edf17
("uio_hv_generic: Set event for all channels on the device"). So this
is the reason why we seeing it first in 6.12.y stable series (but now
as well on olders), but not a problem on 6.17.y.

Hope this explanation helps, please keep in mind that I'm no expert
here by no means, just helping to report it from downstream Debian up
here.

Regards,
Salvatore

