Return-Path: <linux-hyperv+bounces-2989-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD1970AE7
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 03:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D841F21317
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Sep 2024 01:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4FBA42;
	Mon,  9 Sep 2024 01:10:11 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0A3B641;
	Mon,  9 Sep 2024 01:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725844211; cv=none; b=qtdEtFUhu3ppWiXcUY1xHJsjLBNXwWm8e7NUtJijlAZk6yHt6wIC7fLOD82ahPvPKnoqAGRh2Awln7qqD9VtxiEsw5p7FFcJGxwu0Nk00lMW93ij9n8KKRqdK1jajEAb+AX3VIYt/wLk5fOC4orrxEcy+aNuw5uo/DuYgNAIDFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725844211; c=relaxed/simple;
	bh=k22W9rvOfyp2pgn8d+UY6+c0sRNYgfX4OQYILH+Pwg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMX1J8oUraPVm0pKRWHsVNIEigr0DYXGwZEsOptH8wcWtgLf7GUb0uqpCjuwl59shjOZ1qE3XbzFBB3nti57txuLo/UYD0Lwl8htGk0gXbVAZoejob5qo14DjoAfXqOLgz7dSr0stlIZOI3hEDm2BlJFePrS6FjCxw8v8I4YmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-20570b42f24so44635115ad.1;
        Sun, 08 Sep 2024 18:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725844209; x=1726449009;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpfN7cT+vudV1ElYDWl15FOqor4a98PEwIzYGObH2+c=;
        b=ZpX88xr/dpq384HEPRA55qBfwBhiuDX0hBEZdSFRhx2Kjz+Zg6AVjOFBf7Y77jSU0O
         Z046XcEKpvPC6QScEy9Trmg2fEPmwy4uDFAUTk30rLoXuTGEmlBMyepN0c7ToCB67kzg
         qV5rqEdLXrP5Qxu22fhuwgfcZqYyGSNyRRFHVG94rHzUivFALsWbODxYcr1WPoLBsPmC
         7QKMhs7wMN0cpi4emB0UxpvoE7cj4nT1pzfSV8DE+Pf+CgyKo46Zscp7aY/KRXX13Z1/
         yDoYUlOat5CkZcrMaSOxP3E5EzZU8cP/3J9imw/WRu6/0rL286OJHqAMEZrVidPHk6lx
         MiSg==
X-Forwarded-Encrypted: i=1; AJvYcCWkXT/ScLXGsQFstAAPEovcMoAl3e0RlWDlHLGTaqw6flj+LkilUj51MpOLu7aRIEWcGXSbO5/GRaO5WP4=@vger.kernel.org, AJvYcCXgYGNy3CU3YImCQd5SCdXUvFi/OwvNYbk09p7nLmmnMck9HLwiPYGv/KjHOeGxZkvSUbVXUXTmICG4tFP9@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqi7lEYvSfTP7/ltmkWLajCL5wAsRIzKzYnt9sMVcITfJdMME5
	Irpo9gkJJSrkeESXyRRTpXbIPtDjhyEbQbOvdhWs7NfRx3BKf5MY
X-Google-Smtp-Source: AGHT+IEsbzAyJ73On8efEO8PyuACLSyPfTQ0ckYZSrS1cuoyv6XHHKrM7vtETUpr10ElLU6LGKtYXw==
X-Received: by 2002:a17:903:32ce:b0:207:6fb:b04f with SMTP id d9443c01a7336-20706fbb21fmr40618045ad.17.1725844208534;
        Sun, 08 Sep 2024 18:10:08 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e10eb4sm24434845ad.7.2024.09.08.18.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 18:10:08 -0700 (PDT)
Date: Mon, 9 Sep 2024 01:09:49 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: decui@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools/hv: Add memory allocation check in
 hv_fcopy_start
Message-ID: <Zt5K3Y7afzCt2Nvv@liuwe-devbox-debian-v2>
References: <20240906091333.11419-1-zhujun2@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906091333.11419-1-zhujun2@cmss.chinamobile.com>

On Fri, Sep 06, 2024 at 02:13:33AM -0700, Zhu Jun wrote:
> Added error handling for memory allocation failures
> of file_name and path_name.
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

Applied to hyperv-next, thanks.

