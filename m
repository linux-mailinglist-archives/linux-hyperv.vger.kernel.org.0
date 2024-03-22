Return-Path: <linux-hyperv+bounces-1820-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAD78875DA
	for <lists+linux-hyperv@lfdr.de>; Sat, 23 Mar 2024 00:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE5C2845B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 Mar 2024 23:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A4582C69;
	Fri, 22 Mar 2024 23:41:07 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA98289A;
	Fri, 22 Mar 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711150867; cv=none; b=ux/R68QGEz8as4P2AGsGX9OJeDx6TfXuSSLkMyH1OtK7JWkHNoaO9i2rXRdcm3ovEbXnQM5O7Y5hFtvIbUNhvh11v0PMPOCCi7hJ62y6kKtThjLPtU5UBqWtlTS6dNKFThibWxXzitiNljTIXbvfZuyGF2pjvBpMRq+DMvfJUv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711150867; c=relaxed/simple;
	bh=LR620OdnlfauhSshCFr1d9YXxdXQiOPS2QnEpmxDfQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBbRZJKRvcreINiinpQQHjVOq8BLcDA7McoB7UYW26BhPa9XlT79uykMWaDENfR+cPFybkP27SzSkTZxi3MmK+LL98frXr6fy0dQIzBEh8nfJlRT0LggLbaEkvqi95ZdKiRNc+pmdVA8WKtLn0HNzx0XoW150nz6rbHbuQxkMuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d8b887bb0cso1642112a12.2;
        Fri, 22 Mar 2024 16:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711150865; x=1711755665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjXBwbAglu1yYMwyTXD4aueIZA27EbItBgKSZhrhBe0=;
        b=dvl6/yiL0hurU82FUuYOcLt1isRMQWX4F2cy+3tAkU+kjmrfhWVLZqro73DItUIVYw
         zUbyvCADVovT/MAjAFGDfAObltpeWlDLSt66I2f+r+BAV/4TAf4iKU85qlORm3r5bydW
         VmStullTk7j+dAkV2njWl3U0ccM8WSkHSQ/qazOXuXCICSTVeWP1uI3kKm8mbj4aKPzv
         mHwsdUoMpq/oW6DKfdVt9kEs3nkTwEjnmQEkWpuAQWXVPL71xeW/CfcHOE/nUlp5PXDS
         EmN/HpiDhcTsvef7KWxEMPmDtzc/ieEh7vrECGhlR3uSVoSMyiKLpqIOgSTI2k/zYHPL
         qjNw==
X-Forwarded-Encrypted: i=1; AJvYcCV3e8S5pYDeSaUOGEEAx2RPo06Cv18vppfdgyaMWX8Faj4FVe3apHMs7qshwemH/1nVLlNe2pKMTNG+3rc7ASzOX5VrWC5J0iXIYtOf
X-Gm-Message-State: AOJu0YwrQ1cs9cKpjc/oUn3iwW1t5B7M1bvDGyhiL6H/PTb4v6xiQtjM
	5cJGhPRzg89tvR+vkQ7Q9XcFhgckBeAx1RKcM22eftk15b4wHdax
X-Google-Smtp-Source: AGHT+IGIPprIHk41c+SxW4A1ls5Kata/W6CZbvTSJ0bV0QsNl1uAt6p7YmjqZvPsP5j4nO4Zz9HPHw==
X-Received: by 2002:a17:902:ce91:b0:1e0:223f:3a54 with SMTP id f17-20020a170902ce9100b001e0223f3a54mr1624071plg.24.1711150865305;
        Fri, 22 Mar 2024 16:41:05 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id r11-20020a170903410b00b001dddc0f1e0asm319405pld.106.2024.03.22.16.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 16:41:04 -0700 (PDT)
Date: Fri, 22 Mar 2024 23:40:58 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhkelley58@gmail.com, mhklinux@outlook.com, kys@microsoft.com,
	wei.liu@kernel.org, haiyangz@microsoft.com, decui@microsoft.com,
	tglx@linutronix.de, dave.hansen@linux.intel.com, arnd@arndb.de
Subject: Re: [PATCH v3] mshyperv: Introduce hv_numa_node_to_pxm_info()
Message-ID: <Zf4XCtTS9qrGnpg9@liuwe-devbox-debian-v2>
References: <1711141826-9458-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711141826-9458-1-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Mar 22, 2024 at 02:10:26PM -0700, Nuno Das Neves wrote:
> Factor out logic for converting numa node to hv_proximity_domain_info
> into a helper function.
> 
> Change hv_proximity_domain_info to a struct to improve readability.
> 
> While at it, rename hv_add_logical_processor_* structs to the correct
> hv_input_/hv_output_ prefix, and remove the flags field which is not
> present in the ABI.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>
> 

Queued for hyperv-fixes. Thanks.

