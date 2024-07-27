Return-Path: <linux-hyperv+bounces-2600-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED28093DD70
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Jul 2024 07:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3C41C21417
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Jul 2024 05:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAB314A8F;
	Sat, 27 Jul 2024 05:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELkNsDzC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8344A05
	for <linux-hyperv@vger.kernel.org>; Sat, 27 Jul 2024 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722058442; cv=none; b=b4yJSxrxGZ+GvEMMVElUF3PdiF62+NfY+kWUf9Aup7gxsgNJZmLgz2ZAgv3cZ7HFSyymd4NMRfpbgsIVcx4OwwrGYCrdDgnYh57NvDy7F/roV2Vm/MDM4CGyLHw6Ht+qvcLBAw0nmV8TTNiyoeYmtPrEzlEojaUHXMc2amgduY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722058442; c=relaxed/simple;
	bh=W7z9D1l9AwqvXtkqfvvaiEVnjw3TuJ02dQfagSztV8g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fg4xsiAQeaPOOVfSaiydPJ5rbzxL98M7hgB0P5byK6Kdtt2aeT7H9jL3v5Q3N08mmH+A/hVy6hHqPBVIbovf1EdYUXCy9fQUazph61wJoI9LDmbFCo+DLiO/c+0MoZkS7kacMb5E7TKqCt65oG3o/ZpfbE5WulYSSN7+Dtr8PhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ELkNsDzC; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-26106ec9336so1106737fac.2
        for <linux-hyperv@vger.kernel.org>; Fri, 26 Jul 2024 22:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722058440; x=1722663240; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGu0ogYBtBZzC7i8X6qLCIyiHpoQtCp6oDiRTmIQVhs=;
        b=ELkNsDzCeW3VatU9ECypb16T0rYxokhTvnG3czoMlIWankdAkM13F2ZILXuzT4QsCD
         QblAtpausTS+5U7vfSQyk9KCrsQXZRA6Kyy313BuZzOZd56NJC/Gi727nsDoJ2df/UPZ
         7/QT6ihR6ZRwGw7cL+FImSF34TguD9iDII0AmNxkn4CumUjWuzww/YP8rbGmsfvHB4+l
         9uMO6lONM7VKa63jy49M4qlahBUSDB1QKyEvLSDK8Vfm32CIKTqOHCz/PXO95zlEtYQq
         aSBbz/Ubhq7dMCjvIJee0A2IL4sD7SqlBdgCddiaHGw8HnxUZDxblr9fV/gTLe/zC/Tf
         87Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722058440; x=1722663240;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DGu0ogYBtBZzC7i8X6qLCIyiHpoQtCp6oDiRTmIQVhs=;
        b=Tvti7yw22ROCvYEGHLVd+sM100SwN9pRvOARdxVOSv76d2UCfTF4vDKA06FEyxCxm+
         5WPZZmd3TXQsHHqw18GUTl3XSj7YUac4yHkKuo6w9FDpLvu6rujPIpxcgkfUo6PhG5i7
         t90+i6v7lYYw+aOBMrkLrIeA76Cozh7NOp2OPsBChcGWQYIQcuqSFt6uW3UheCo0goAl
         +N/l0Sz5TR5l5zItyzGyaVH6toU3/UltwpcxQh1HaNcZSsel1GFy95vFRZ8LX+cH6Pg4
         ACf3f7jNk3IDVxIDb31kLYQiCSnk62+kbSVgJ4OihNx6kHflYkuihmz+MntSDtaGx4M/
         1bLQ==
X-Gm-Message-State: AOJu0Yx2j5VBeJwR0utPWSF4MeeSEcAi39g/YWtbfL/H8XSV1uezxF6g
	QL+cJmVqGORQGQxruI1a/U1qx1WcL/cM+H5zO0I3OE7QHSQjtkTQw0XI4Nr4dNU=
X-Google-Smtp-Source: AGHT+IGNkaRysTG+cnrmwOYjWJuwRTb60MWhIhLY5qFtjmaoehh7Bvp/6SZr/0uyPkITrp0hVkKqzw==
X-Received: by 2002:a05:6871:724a:b0:261:1177:6a56 with SMTP id 586e51a60fabf-267d4d5dbf5mr1996922fac.20.1722058440171;
        Fri, 26 Jul 2024 22:34:00 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1cb1])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-265771e4907sm967934fac.35.2024.07.26.22.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 22:33:59 -0700 (PDT)
Date: Sat, 27 Jul 2024 00:33:56 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: linux-hyperv@vger.kernel.org
Subject: [bug report] Drivers: hv: vmbus: Track decrypted status in
 vmbus_gpadl
Message-ID: <4036aa13-e8e1-413c-b0ad-5b82b3f2615d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Rick Edgecombe,

Commit 211f514ebf1e ("Drivers: hv: vmbus: Track decrypted status in
vmbus_gpadl") from Mar 11, 2024 (linux-next), leads to the following
Smatch static checker warning:

	drivers/hv/channel.c:870 vmbus_teardown_gpadl()
	warn: assigning signed to unsigned: 'gpadl->decrypted = ret' 's32min-s32max'

drivers/hv/channel.c
    860         list_del(&info->msglistentry);
    861         spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
    862 
    863         kfree(info);
    864 
    865         ret = set_memory_encrypted((unsigned long)gpadl->buffer,
    866                                    PFN_UP(gpadl->size));
    867         if (ret)
    868                 pr_warn("Fail to set mem host visibility in GPADL teardown %d.\n", ret);
    869 
--> 870         gpadl->decrypted = ret;

ret is error codes but ->decrypted is bool.  So error codes mean decrypted is
true.

    871 
    872         return ret;
    873 }

regards,
dan carpenter

