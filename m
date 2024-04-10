Return-Path: <linux-hyperv+bounces-1951-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D66D8A01EC
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Apr 2024 23:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5829A28390C
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Apr 2024 21:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0711836CC;
	Wed, 10 Apr 2024 21:26:27 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7B428FD;
	Wed, 10 Apr 2024 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712784387; cv=none; b=kGeJqHo4iUgLDp3dfO8sBngyu5MDy15mMVsabkvvU6cHvchzw9svVS3eINkwA9gGFvn01azHTqay59u/D+ki/7DmuWKiTrYDDHAW/t97frBxCdH1uvZYzwbI32P4b4NgcmTfm0lMYadeaT+HKDsIaI22FVkHcT7e2yBnX/mfJzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712784387; c=relaxed/simple;
	bh=08PnHTmoFjVS0jlauVqPE5m5O6Gpq9uPAIfvA5nIff4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h6/+LNpUR6nHLXRAM+G34WzQaQgN4UMPWfK+fKYLyl0vIkCtRkTS4Ax0sbhuV0jDA/f4UZ7LchC+s/gMev3u7mpRygKnw1kquNRwj7bRFpFlw2iBWRXSpOPVRCU9xrkwmDx6NIwO2jSN53af8d7yFN+bSr1Vxs+5bCLgp4X3dmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecee1f325bso6444950b3a.2;
        Wed, 10 Apr 2024 14:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712784386; x=1713389186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHYBoAuG9Ulh100IdFDToigwRpMmG8N/QPRwV2fsKV8=;
        b=LiAv8qniH33yMNtmCiheFzNIhvlanNhSm2LfijaGTG/z90ncV2MOafK4yoigizGw31
         Aa0ZtymHmrv2/BdVMRPa4GXBSdoA4hutu0vbRrazImwSt0O/rQC5AaHy61mZ+XMDlnPs
         MI+m7+s43TbFDfFpCt4DpZp1MYanwVfoWky/T5A+64i6bUzvoREVifKRFbFx7vYFOxNA
         XceCHppWv4mjYF5T06wqfT5/4aUk2VcLwYOH6YMnZXUK9mX0EU1gHL/M10WuGf4V4zM2
         zmoUg5CMRlHL5M4GjfPIcbRFbNuGRvw5QOvCOl0XE2BUVUWFzXTVuXvzlWPhw0nFiPP3
         9zXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFGESLn+4Z9oXhRm/f64R8fOjFpzXAbZgQOPuDVauI4GuWYSOf6hFYD9lMFnr65MeBGrEtQVScSrFAqqiiucA1+4xXcnLhoIpa9tZ4
X-Gm-Message-State: AOJu0YwuOu3qf73wTmBziqGynGRaqsSyeDN3ewNOSgqhtz8Vzh7I8JmA
	wBify58Jt2xWu+e6fZ+qQeLEusVcweYUQzbm0SNCIDol069O+i/M
X-Google-Smtp-Source: AGHT+IH5VL2a530HRuWElepuAePCA6LOgeT7Ow24WI7nKi3lLcAM3iNhWibNJV9EC7NSeYPLlOiMQA==
X-Received: by 2002:a05:6a21:3482:b0:1a7:1df5:c329 with SMTP id yo2-20020a056a21348200b001a71df5c329mr4763123pzb.0.1712784385884;
        Wed, 10 Apr 2024 14:26:25 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id g21-20020aa78755000000b006ead618c010sm93243pfo.192.2024.04.10.14.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 14:26:25 -0700 (PDT)
Date: Wed, 10 Apr 2024 21:26:16 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Olaf Hering <olaf@aepfle.de>,
	Ani Sinha <anisinha@redhat.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v5] hv/hv_kvp_daemon: Handle IPv4 and Ipv6 combination
 for keyfile format
Message-ID: <ZhcD-HPMsghnJs3X@liuwe-devbox-debian-v2>
References: <1711115162-11629-1-git-send-email-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711115162-11629-1-git-send-email-shradhagupta@linux.microsoft.com>

On Fri, Mar 22, 2024 at 06:46:02AM -0700, Shradha Gupta wrote:
> If the network configuration strings are passed as a combination of IPv4
> and IPv6 addresses, the current KVP daemon does not handle processing for
> the keyfile configuration format.
> With these changes, the keyfile config generation logic scans through the
> list twice to generate IPv4 and IPv6 sections for the configuration files
> to handle this support.
> 
> Testcases ran:Rhel 9, Hyper-V VMs
>               (IPv4 only, IPv6 only, IPv4 and IPv6 combination)
> 
> Co-developed-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

Applied to hyperv-fixes. Thanks.

