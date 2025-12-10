Return-Path: <linux-hyperv+bounces-8004-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A90CACB2586
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 09:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6382830069B7
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Dec 2025 08:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D83327EFE9;
	Wed, 10 Dec 2025 08:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HoLaXPJR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200AF2DF128
	for <linux-hyperv@vger.kernel.org>; Wed, 10 Dec 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765353764; cv=none; b=AF+Z79B27IYuqdDU8FLecVCdxkcupwFYZpgStt7/2q1fgy3lpXv0cpjVD5ml3tQpLqfb4EjxkF7Wk4HjfL8Mco3dEPR7cnnipO2aQfXW0pb9VL02fDb091FybF3neQ1Bg0RScjY5zUQW52r0CYpy/Bfk1xLHyBZOgA6jvyrEwrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765353764; c=relaxed/simple;
	bh=NwjeKU/Kv0/596dUdnow/+DmL0ty4dFlG3SgImSwAdI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sUEhag4EZwgSeyPYRUe5JomOCXBZFEx6R+byxKhswp/0Kt8efwR60M5DphIioIuB4FSXd4jxduhnjvL2YYAO70GAqGAMOqGok6wt5fLZB+UGrHa2v+TEQ4gYN18nxZpN7OYgOdBMERqihEyTyXGjnjCALgAxrieuZotmvkolynQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HoLaXPJR; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47795f6f5c0so42195905e9.1
        for <linux-hyperv@vger.kernel.org>; Wed, 10 Dec 2025 00:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765353760; x=1765958560; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02qh7dunQtiYM8uxdaTRP0efQmrwDBmNLRwwWN0D37U=;
        b=HoLaXPJRtGFKyViMCXIQxvPFibnYXta9oaqznu39Pc3dcSpLTIGQBugxLjSPvH80Rm
         tV6oFN/Lt1eSyhL1j8K6IQfXOxn7ELzJuPfanpSh2oB1dTH59+zfnOUlNnyOrgQWVatC
         izgKMy4zlgmi69WGuiSiXNGYfdxHJuyndvmLfXa7zzCS94wHoYV9NXqHJodIeM/qI7EG
         oOXloebwV15uPeMSpZjjFQohgduwB6acYEU1u3cacT373vBXXGM9Grz44LKjlLhvnboL
         49/1AoRRMrBsUSkV/VNTDcs6SwHBF+P2xj9xbohlxVZoEiJZ0Zq9vDVuq5KM+KvxHVMK
         lhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765353760; x=1765958560;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=02qh7dunQtiYM8uxdaTRP0efQmrwDBmNLRwwWN0D37U=;
        b=f0fNwQdf5k5PBezbWE8fkqsDYhTvZGOQqtuvVNxsCmjkxt0bw2SeLlj6UmjT6uXHOp
         IyQ196t+lyrJUDq2oTwu7lvVZXQGIwz5hahrrKrgE3TvpgqsQn0coQ9TIJDS/GeJLUSD
         CTi63agTyMYySnB8Jc0/OmqUMWmgoi8avnw9BYT5zGZogdGDOgEC26sx1xQ/BOJm2jND
         e2wgFoxy5CLnO0Jiq9bQ6zfPvhDP7FQbYQ30MXq1hNffnxZAkTtfc8pc3bRHoDwRCiVL
         SvNgdcGDIaZZmt1zP9MTo0qmLycOOlH/XqT9vXWcSfc9NiBpC9P6Hophwpxelfhpy6m5
         Sf8Q==
X-Gm-Message-State: AOJu0Yz/6HFGW8Fn+jguNbIafVsGehwbVJ/DYfK66j4ZDMDILNnJf+23
	PU5WtX8WGQX1ZtFaW14wAFr0uQvPLLJn+TBdIIpZXX0mnx1YedTRZ+uspbBcm+nSqRg=
X-Gm-Gg: AY/fxX6oI2TWGESkQvG8GIVMsLmQUCpwV+WhgHmSlvDFwDGxa4y++0gYcvN+tHPtQT1
	8YVJgqsOIa2k0UxHjJWjlHptImShXx2Hx75ALB8Tg9xyt9mrDhF+/B26ch9if+gA2mvFmJL2nFb
	ivyAm8CW22LZ44UY+/6+9yRCBdL/3Wkd3eA0WZQ8m6aHP8A+7jm+M04i9W4AQSeJpby4zD4wIrw
	t5YOEtlwtJXyvW0VYdD21iL1+bhH5B4xfZfXDzzB31TsvMEpftEua0x8uj+Oqmg9K6vex0f2y16
	OUcgrAYOVQ0jqjMUMEj7ij7vcdZxgYVx7HkFajJt88Rc5c7+4rd2i2nq5A1kC28evO/zz6R20az
	Vzl2+5mFllOj1Qgm8VkvF2X6dEOqc3Op+ijdxxGK51BH8P+EjXr/Vtfmu042W9CQQ3X7rHEhFei
	u4L3gsyoExOuQ2UGr3v0fb60fBWS0=
X-Google-Smtp-Source: AGHT+IG8HZnYaOflflzw10o+janfWMnRa0+pZDCB3VzJ6+Zm9ZUIUKGxFYtUZ3W8RO5klu5lC+Rmig==
X-Received: by 2002:a05:6000:2211:b0:42b:3ed2:c08b with SMTP id ffacd0b85a97d-42fa3b06401mr1303263f8f.51.1765353759947;
        Wed, 10 Dec 2025 00:02:39 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222506sm38559037f8f.28.2025.12.10.00.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 00:02:39 -0800 (PST)
Date: Wed, 10 Dec 2025 11:02:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Subject: [bug report] mshv: Add support for movable memory regions
Message-ID: <aTkpG8Edx_N3p5g4@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Stanislav Kinsburskii,

Commit b9a66cd5ccbb ("mshv: Add support for movable memory regions")
from Dec 3, 2025 (linux-next), leads to the following Smatch static
checker warning:

	drivers/hv/mshv_regions.c:523 mshv_region_interval_invalidate()
	warn: passing uninitialized 'page_offset'

drivers/hv/mshv_regions.c
    486 static bool mshv_region_interval_invalidate(struct mmu_interval_notifier *mni,
    487                                             const struct mmu_notifier_range *range,
    488                                             unsigned long cur_seq)
    489 {
    490         struct mshv_mem_region *region = container_of(mni,
    491                                                       struct mshv_mem_region,
    492                                                       mni);
    493         u64 page_offset, page_count;
    494         unsigned long mstart, mend;
    495         int ret = -EPERM;
    496 
    497         if (mmu_notifier_range_blockable(range))
    498                 mutex_lock(&region->mutex);
    499         else if (!mutex_trylock(&region->mutex))
    500                 goto out_fail;

page_offset and page_count are uninitialized.

    501 
    502         mmu_interval_set_seq(mni, cur_seq);
    503 
    504         mstart = max(range->start, region->start_uaddr);
    505         mend = min(range->end, region->start_uaddr +
    506                    (region->nr_pages << HV_HYP_PAGE_SHIFT));
    507 
    508         page_offset = HVPFN_DOWN(mstart - region->start_uaddr);
    509         page_count = HVPFN_DOWN(mend - mstart);
    510 
    511         ret = mshv_region_remap_pages(region, HV_MAP_GPA_NO_ACCESS,
    512                                       page_offset, page_count);
    513         if (ret)
    514                 goto out_fail;
    515 
    516         mshv_region_invalidate_pages(region, page_offset, page_count);
    517 
    518         mutex_unlock(&region->mutex);
    519 
    520         return true;
    521 
    522 out_fail:
--> 523         WARN_ONCE(ret,
    524                   "Failed to invalidate region %#llx-%#llx (range %#lx-%#lx, event: %u, pages %#llx-%#llx, mm: %#llx): %d\n",
    525                   region->start_uaddr,
    526                   region->start_uaddr + (region->nr_pages << HV_HYP_PAGE_SHIFT),
    527                   range->start, range->end, range->event,
    528                   page_offset, page_offset + page_count - 1, (u64)range->mm, ret);
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    529         return false;
    530 }

regards,
dan carpenter

