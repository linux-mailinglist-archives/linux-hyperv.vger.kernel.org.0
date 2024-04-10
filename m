Return-Path: <linux-hyperv+bounces-1952-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4A18A0219
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Apr 2024 23:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29111285295
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Apr 2024 21:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0BA1836EB;
	Wed, 10 Apr 2024 21:29:31 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116E01836CC;
	Wed, 10 Apr 2024 21:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784571; cv=none; b=Q+WjR7BWuAFO9y4vajm0VmzEdwQdqPgHsNsVuaSu+Z9llAbB/ENHghHQRCiLsU2DfrogqKxFzdnEbvbqYu2Q6j3cAGuxZzPpHRKZ/JO2AP1uYiqsk6hU2H55CETViQr/6G/2z49G4NgH6JqJv1TMrvawW9hdW8ePiebE+X6LLxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784571; c=relaxed/simple;
	bh=M2o6cMnM6nNccjw9LvHkRSGksxMfQg0bMf35FBJLDdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AsLe3tS2CbPW37EbroCkuxBUESjmAmR4YPq5kcTSMYYZp6sMUNOoYTbJhOESb2RpQGJM+shrRp3o2DS2q5e2fDe3lTWidBRMjl7Q/xyBG+Kgkdooh3D6/TNfcAykrkzMxOZjWORwHD+ecWRc7xtioNIqTdj6+WLh70C9oj+jDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1e3f17c6491so34977245ad.2;
        Wed, 10 Apr 2024 14:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712784569; x=1713389369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6EaonafyjDQr9SviaAlUYtrZbN5OOCyY+aDjZUNocc=;
        b=D2jdli0Vt51kB42VAlTXi6vTNRBnEWIWaW3IvF97M8X39y99aLbtjxs3Ii0ifNgClh
         zxQoVLReAjvh5EnHPjyIXfOrdUoUXMhaaDg9fmXkVxKmh9xDK+2DDll8NvD4k47NsIRo
         eh+A+KDQOaq8cNU78FgWmW7MWz5R5ggctYOcneT13CmlL2sOrEaTChT0vOAdDdB3T4v6
         HCjs0rbo+1KzkqDzSBcWqAYxvIuoI1L42lEgZaEWJ5szxty01aXiJY+snCH+fm4xBZtw
         3974ehEv961CjmiJ8p8vUgSNUYbrhmmkUe1LQDIvJsuNEQzdC3wYciMBF+ErPWFX1Eop
         hg2A==
X-Forwarded-Encrypted: i=1; AJvYcCWbT9tQD9JxtuV0KcBSM9BxUYMA2EgeyN3rrg3xf/dm9kyJcvUUTFeFmOrbR1TKyujNQCl745ZosfJ0nHa+lBfBlJ89NMvM0MczQX7+IKT5dw4/UUFWF0QL3TqvQTUwy1ybMW52pZxzymHN
X-Gm-Message-State: AOJu0Yx//06y93KY/0WqNs3q3z6nd4INrHQoagxpBWkLqXaeoGLtJvMu
	/ceKHgadAerKW7nC6Hw364VXegLi2K3WfzvjhYwqVhypI23/NQxC
X-Google-Smtp-Source: AGHT+IF54sYTekrt+L4azV8csngPC/DPwaQhKRwxPTSbmEzd4jdxr29xO2uAZ5xGCPCaGJoyRm/MZg==
X-Received: by 2002:a17:903:2284:b0:1e4:17e4:3a30 with SMTP id b4-20020a170903228400b001e417e43a30mr4879017plh.31.1712784569275;
        Wed, 10 Apr 2024 14:29:29 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id mp3-20020a170902fd0300b001e4028c9d60sm1411plb.212.2024.04.10.14.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:29:28 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:29:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Aditya Nagesh <adityanagesh@linux.microsoft.com>
Cc: adityanagesh@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Drivers: hv: Cosmetic changes for hv.c and balloon.c
Message-ID: <ZhcEsPZu7QZxr7DL@liuwe-devbox-debian-v2>
References: <1712030781-4310-1-git-send-email-adityanagesh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712030781-4310-1-git-send-email-adityanagesh@linux.microsoft.com>

On Mon, Apr 01, 2024 at 09:06:21PM -0700, Aditya Nagesh wrote:
> Fix issues reported by checkpatch.pl script in hv.c and
> balloon.c
>  - Remove unnecessary parentheses
>  - Remove extra newlines
>  - Remove extra spaces
>  - Add spaces between comparison operators
>  - Remove comparison with NULL in if statements
> 
> No functional changes intended
> 
> Signed-off-by: Aditya Nagesh <adityanagesh@linux.microsoft.com>

Aditya, for the avoidance of doubt, I'm waiting for the comments to be
addressed before taking further actions.

Thanks,
Wei.

