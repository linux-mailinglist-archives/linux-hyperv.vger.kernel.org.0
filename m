Return-Path: <linux-hyperv+bounces-7481-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD5BC4523B
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 07:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE3014E824D
	for <lists+linux-hyperv@lfdr.de>; Mon, 10 Nov 2025 06:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E01B2E92B4;
	Mon, 10 Nov 2025 06:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ab0tfpFz"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF72E8E06
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Nov 2025 06:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762757796; cv=none; b=aHy+Ddamcf6O8XiPsQOOApDv8tNXxkoJ+NUtAM0HeMqzVgNUirihrEYp8tiWIvGoH8zKctTAjraI8Yt0Sjp9YlW337BbrIwvN5XFVJPF00FhfSX6Eiyh6aOba/jWamnf/um+Rib1BFdQaNYRYRqAkpr7VQmnsg77ttFUKWvB91s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762757796; c=relaxed/simple;
	bh=1WY1CcuShlRk2we91Kyt0bCpaTxBq3s2lFYDIeGQFjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rvqEYsl3JN47iYKGANTbgFkFvwP0cR+KY+vRbkGlxeahcqblKcWHMbvji49YCNpdkpNgK63VH6CAxvNYl3JKeKl5nXuCQEaWFOjNMN4Ufw/FHSXDnmRkXqqqgSp4XkoxCU44jNhOOPTt40DbaadhFLr+7wE6H4+uuyYj8lV5jqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ab0tfpFz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-794e300e20dso1812168b3a.1
        for <linux-hyperv@vger.kernel.org>; Sun, 09 Nov 2025 22:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762757794; x=1763362594; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1WY1CcuShlRk2we91Kyt0bCpaTxBq3s2lFYDIeGQFjc=;
        b=ab0tfpFz7N8LEMnO9+dPg1y9BZlC+FL7v2HxxPeRaqSUgiD1fwyw36l0SaocrFfSxm
         Ya6zMe+cc2D5+aVpvHX4wMzFUzPNQJERWrXmdTtifhSIx8gHqMBsv1X+6ZxsIwS64W10
         EVGSTcJ9atHm1GQtDGHC3DrAXu6sv98tCumDL35KcdAxeZxvxJ6hK4RalRfQl5Xry2EK
         Hyo1uuXmxMD4Gfo5G3Enr0IBkt9Jx+uVOgSukWNdSEc7bhm0pF1Fi5m1vAfx4J7q5svL
         uPh9hD43gvKbvkNSnn31AZko2CLp448PRIC/Pz0NVMOUZe7xWmYaO91yz8ddgLq1cQyL
         7JRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762757794; x=1763362594;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1WY1CcuShlRk2we91Kyt0bCpaTxBq3s2lFYDIeGQFjc=;
        b=kTnxsGAbuSD+us2lkwgxMN2RDXa9tPYMGjzbwELs4Fqt9qOGwIQbTvmWuGxMZ7l0C3
         GoYsz/o6KRXv56An6LHWx1r5UAS+SMnS7N3XTWngTYBdYD3pIjBqiLaJjPKhx2n0TGX+
         JIDekJQpzyKivGX27K1T4R/cZM3vxwUJ4o69YN3wiOImkIWxNzyr2X44YNFLEH0Gf71j
         npaNwyimG4LNnMCIAxxHKlGupyY8Nz933NMcSO8DVAk3ThxhDmOZMjWXfV6U0YHHqivc
         sz8mID5CFd666iYK9equDNu1NuBAlMw+xJpzxK8VzyucmV47uq0RRozs0VInGlQ7zTKS
         ceXg==
X-Forwarded-Encrypted: i=1; AJvYcCWBUZ2/umSGWuOdw3XxdiHEqOyM7LES13VpHYWrJ5skx2wNSz6U6gf/SWX6JAYYtRbmyikSBhYhgujAmt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8Ly61TBMvQanUnVPxIfvXFnzSReye/lHgj6DFrv9z2YRPMUaS
	M7ewDMZmFE5Jxwn8CF37hMh9CPx/EK2WG9AiB+/VbZWhd7GXAFg3hryE
X-Gm-Gg: ASbGnctelRgnQ/PfTHEngfVqSLD01BHjI/Wk/QF65Hlo1lilcu/LsRN7aZDhQohWOfC
	O7SJG9Sd5w5bdXfQ/ftjmGMOP+uZuZKPr46jGPNjLwkdX7EcPCRfMZCYvmeCUJhKSXDQN4jVADR
	jHxq34HYlMng9mvT/9wy1ETxkxTEVs9UrPlSFJn7bT3MZD5reUjk2ZIWLfAk1gkpnsL+2WOlEGg
	QHwas9aCRoDnma6P9qyYHoDjUb0vWqjgVCqKXERfLlDWzNHN+W6UsD2lUfwKtUv/mshem0OA24i
	5Ei+FmoBFwZKjXCN+VcYS0ME6y7pc7+sAUj+U+Cjx+pOEJUvKDqAQ+VuxoaOJJtDdz4jwGce9q/
	yaqdII25iA0aaGSPBQQ+0ukpqRuFid3WVhaxAiPf++VmWettu1KLu3/BpUN9ovqtB+UKKq0GRQa
	1+9IZzxzlShu2++b9Hukky30hzMy53L4MkQ4Lk6QbH2ewCEQGWyxmEnALPOQ==
X-Google-Smtp-Source: AGHT+IHO/HHwLn1ypxfIScvlrVfWexbtPhQMjjTTwSmPh9HSJNcv+2vgzbGH5WKsvvttQQePqFv3dw==
X-Received: by 2002:a17:90b:1d90:b0:340:9d78:59 with SMTP id 98e67ed59e1d1-343535f6b33mr12883342a91.3.1762757793661;
        Sun, 09 Nov 2025 22:56:33 -0800 (PST)
Received: from ?IPv6:2401:4900:92ea:6c8b:9820:381d:1e5e:1579? ([2401:4900:92ea:6c8b:9820:381d:1e5e:1579])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f9ce9645sm11854081a12.10.2025.11.09.22.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:56:33 -0800 (PST)
Message-ID: <726395fa54b40f117edc0a72285d28a70c156912.camel@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH v3] net: ethernet: fix uninitialized
 pointers with free attribute
From: ally heev <allyheev@gmail.com>
To: Simon Horman <horms@kernel.org>, Alexander Lobakin
	 <aleksander.lobakin@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel	
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, "K. Y.
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang	 <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui	 <decui@microsoft.com>, Aleksandr
 Loktionov <aleksandr.loktionov@intel.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, Dan Carpenter	
 <dan.carpenter@linaro.org>
Date: Mon, 10 Nov 2025 12:26:24 +0530
In-Reply-To: <aQ9xp9pchMwml30P@horms.kernel.org>
References: 
	<20251106-aheev-uninitialized-free-attr-net-ethernet-v3-1-ef2220f4f476@gmail.com>
	 <575bfdb1-8fc4-4147-8af7-33c40e619b66@intel.com>
	 <aQ9xp9pchMwml30P@horms.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1+deb13u1 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-11-08 at 16:36 +0000, Simon Horman wrote:
[..]
> > Please don't do it that way. It's not C++ with RAII and
> > declare-where-you-use.
> > Just leave the variable declarations where they are, but initialize the=
m
> > with `=3D NULL`.
> >=20
> > Variable declarations must be in one block and sorted from the longest
> > to the shortest.
> >=20
> > But most important, I'm not even sure how you could trigger an
> > "undefined behaviour" here. Both here and below the variable tagged wit=
h
> > `__free` is initialized right after the declaration block, before any
> > return. So how to trigger an UB here?
>=20
> FWIIW, I'd prefer if we sidestepped this discussion entirely
> by not using __free [1] in this driver.
>=20
> It seems to me that for both functions updated by this
> patch that can easily be achieved using an idiomatic
> goto label to free on error.
>=20
> [1] https://docs.kernel.org/process/maintainer-netdev.html#using-device-m=
anaged-and-cleanup-h-constructs
>=20
> ...

Understood. I will come-up with a new patch series for removing these
two instances

Regards,
Ally

