Return-Path: <linux-hyperv+bounces-1448-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2C882FEFA
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jan 2024 03:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45041F26202
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Jan 2024 02:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF61C0F;
	Wed, 17 Jan 2024 02:53:27 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECB71C05
	for <linux-hyperv@vger.kernel.org>; Wed, 17 Jan 2024 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705460007; cv=none; b=XekKl7LhUVIbpkLtecr9q79NX48Pc1OZks/QMzUCf10gP1RV3oRzqwXUcEHVxsd9ihaDD2B7YQfXAjUbPdHcLqKHixrFlJTRLeD9oDwLwy2ra2c81YyQcmW+4n8Ke3d/JtIEv5i4eTpmbKztjk0e9yT0nV8VZB1durWDfKGHJgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705460007; c=relaxed/simple;
	bh=gpMe888YvtJnOQcPd2e9tU0fRIAe3aKiVSHIQI4ytT0=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sYq804KqU+De2RpE0PssuZXwEm0IZ+gngXhCVkUTQUEV379LneXm0ckKof9KANjk1/A5b3uHVIvmLleilXfkKHj0KDjZFjLwlwBusA1/QJOYp3gQLyvgnpgJniQYibvuBGGFuoBwyIqaFMACA+SV8okN2laZL6lw/Panrod8+gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6d9af1f52bcso5285351b3a.3
        for <linux-hyperv@vger.kernel.org>; Tue, 16 Jan 2024 18:53:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705460005; x=1706064805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gK7wq43fs5/XGU8CCoMISRcb9lNGq0YDitZ6AgU4XYg=;
        b=FSqkmUfAQ/ErHvOx143emWBIMR0TxMS3qhP5THfxPUINkxDLIsdMh50Dls+tGMIBJ0
         +NlJWQq+I4B6qTPkhGMAqUoaLo0t4LzOBr/GeXVfKGN0P+IY9ZsMQ4GSt1fghHY9V0KX
         vLY/cjCk2NG5g4u84etBW8f0C8eKsdg+rxwNrPtSJfUAngOYGGQcXCBTA94dDbibxv4k
         cVR+i6ChOB0sPdpGalAPw4UTWACdsHETSTdMtzmYsQMACsqyAXQctJDhwSFOTCNwkMhx
         ktHOK0zEdf58FgaD38qZL7MSa7emGWwHgnQOlhRTkAH/lEDrIGMRhdUWe9lpqlvCQPl1
         Vwsg==
X-Gm-Message-State: AOJu0YzgXCba6UckJRgrlHqDy1MdFWpMfj/aebV4zS274y265gHotxKQ
	bymwLFP4rikluXu9FsDxJV0=
X-Google-Smtp-Source: AGHT+IGu+GfTvSQYAZ9V4Tr0aWpvL2VUPCTFjYQXuIQSwZ02/Q3JPzQ/IXiBYmj6t23o6W0zgHZtAQ==
X-Received: by 2002:a05:6a00:1790:b0:6d9:a5e9:528e with SMTP id s16-20020a056a00179000b006d9a5e9528emr5598146pfg.30.1705460005275;
        Tue, 16 Jan 2024 18:53:25 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id e11-20020a63d94b000000b005c200b11b77sm10880416pgj.86.2024.01.16.18.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 18:53:24 -0800 (PST)
Date: Wed, 17 Jan 2024 02:53:23 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Yu, Lang" <Lang.Yu@amd.com>
Cc: Iouri Tarassov <iourit@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for
 device allocation
Message-ID: <ZadBIxlwV_0KJ0oH@liuwe-devbox-debian-v2>
References: <20231227034950.1975922-1-Lang.Yu@amd.com>
 <MW6PR12MB88989AD3AA576FB36A023C33FB732@MW6PR12MB8898.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW6PR12MB88989AD3AA576FB36A023C33FB732@MW6PR12MB8898.namprd12.prod.outlook.com>

On Tue, Jan 16, 2024 at 01:58:53PM +0000, Yu, Lang wrote:
> [Public]
> 
> ping
> 
> >-----Original Message-----
> >From: Yu, Lang <Lang.Yu@amd.com>
> >Sent: Wednesday, December 27, 2023 11:50 AM
> >To: Iouri Tarassov <iourit@linux.microsoft.com>
> >Cc: linux-hyperv@vger.kernel.org; Yu, Lang <Lang.Yu@amd.com>
> >Subject: [PATCH] drivers: hv: dxgkrnl: Allow user to specify CPU VA for device
> >allocation
> >
> >The movtivation is we want to unify CPU VA and GPU VA.
> >
> >Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Hi Lang,

The driver is not merged upstream. I won't take any further action here
because there is nothing I can do. Perhaps you can work directly with
Iouri to merge the change to the driver he maintains.

Thanks,
Wei.

