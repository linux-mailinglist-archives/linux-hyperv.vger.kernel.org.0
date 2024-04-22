Return-Path: <linux-hyperv+bounces-2021-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219708AD747
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 Apr 2024 00:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C151F219B2
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Apr 2024 22:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAF51CF8B;
	Mon, 22 Apr 2024 22:29:02 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F30B1DFF8
	for <linux-hyperv@vger.kernel.org>; Mon, 22 Apr 2024 22:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824942; cv=none; b=Ei/4RFJiUCC2RJijpqr9C0OHqxzjEP+pF48RXAnWN00hv+aGfDPZnLVbgU0j7e70ZmgHGzWbVjnoY0n9vKuCG89USdnKa3fSLBKNTFKqEVKN93V5fH+SffhAo0bfxsQCISqbA5f8bJkwGiLD2BtlqeEQOtSmzoI7/n1iZke8b8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824942; c=relaxed/simple;
	bh=U0fxksQslgnE89mvg43U+1vmjOCz2KlNMrt52+MtWaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T+9DzvkkfBAMXsg3EyPgmaynTMZq7WlCM9Uw4LPkzjyDuSChZxxjS0nlQ5IGoM6s91GTjdMFAjkfXzAYusKpMxsBs2KqC+CwLsZ0BMziwi7zFz7jR691a+X4jmuwC2nZx1RghSEEZbJZISs7ggLUW4KpKpHIMxe84qHO8zSW4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so47727785ad.1
        for <linux-hyperv@vger.kernel.org>; Mon, 22 Apr 2024 15:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713824940; x=1714429740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XBPicW9htWKTDA2yPbffwBm7HGQX0sZptKJ2fW4ZjFo=;
        b=wlg5lroibsepMxFtuVnNXPFCqw+H0SEmOiIbhFyZA/xkDWbcFp9oiPJObgSzIss9/a
         x0yyOM6XH05zL53Nxha0qL8BSrHpLmc0p2Xb3LsMDCVYPslRILSUMJ+6UtkxJ1UDUpzi
         toop8h/OrW/hiQF4/bhJDHwaRdPa2/4tZwe5tWXRFVAzg5If56+2uRtT/aGo24beVgGZ
         XBKD1RyupuTiZuL8jo+4G/qbXJp0adGjzMuAm9VP/fOb4wgUU25CpZH2kpK6tRZCOBBE
         Tpz3kL9amz8eb65rzh4TL+RarSPFFDo41biqf4SnafaPabtSSZstyvwaO9RmIKfARagP
         iHRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQpJg719pM3OYsRT310eKHFagXK/A3aYp72S8jXUl2DEqWWunY695b+M6Leca0B2ac7NzrZ1D3gjjyNF/MiloZ2srCegHMnRw3zJkH
X-Gm-Message-State: AOJu0YyidnanJd+dTFTgDw5KC8EtqNMe/6q+SmSIqg+WP4CwXkI6Drj/
	daYSgCvBVbXGpkxyNQl9pUn2AVRZrXHUu/Zep4X8nMiouI4dvLNG
X-Google-Smtp-Source: AGHT+IH58saGqIVODGi6s4WjoB/DKcmTTM/0rhJ9ind7wM6P5gXwo6XdX3dZUdfNfArBP9j2SdBNhQ==
X-Received: by 2002:a17:903:41cf:b0:1e4:fd4:48d0 with SMTP id u15-20020a17090341cf00b001e40fd448d0mr16699232ple.62.1713824940244;
        Mon, 22 Apr 2024 15:29:00 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id jz15-20020a170903430f00b001e4e8278847sm8659012plb.56.2024.04.22.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:28:59 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:28:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Li RongQing <lirongqing@baidu.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, x86@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] x86/hyperv: Consider NUMA affinity when allocating
 memory for per-CPU vmsa
Message-ID: <ZibkqT2XMOatmkcK@liuwe-devbox-debian-v2>
References: <20240415085712.49980-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415085712.49980-1-lirongqing@baidu.com>

On Mon, Apr 15, 2024 at 04:57:12PM +0800, Li RongQing wrote:
> per-CPU vmsa are dominantly accessed from their own local CPUs,
> so allocate them node-local to improve performance.
> 
> And reorganized variables to be reverse christmas tree order
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Applied. Thanks.

