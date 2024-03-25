Return-Path: <linux-hyperv+bounces-1826-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F47C88AD94
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Mar 2024 19:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE29A2A5DC6
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 Mar 2024 18:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F616CDBA;
	Mon, 25 Mar 2024 17:49:58 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9A25DF05;
	Mon, 25 Mar 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388998; cv=none; b=pgUqCJWajiiZZeBJJX5K4l+H91plbIe4rIYpqlXLrDj0qabzrZI2B/sWvMqvuoty50kAyfNnxCy4iuf7ETLa8AvFV/JNTSNR5H78VO1U4w27yAPPyhJHSJXZtBQRkP5zsji4Ca8r8XJBdflIsqt/Bi4epf0X6WxnIsSVkOkJlkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388998; c=relaxed/simple;
	bh=Xs5j6PZ+Amv9lFcBhVEyDHEokVP2Oob/yLxK3hp3P9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GN8snzcomVIQqP8/jXTWsk4Ot4AHbwIWbMR3NNkLNYQ6IqLirzCCN6Y+Q9NV1tCZBt3h0Fv5ugJkE80GPm1pe7czHYmxw12AMAuuYbfKGAHNyLERraBCs+WqeBEWU1/ueBzPNbDrCFjbyO+Xe+lSmcs5QpoxZsT4VmMynwpPNn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dddbeac9f9so29162235ad.3;
        Mon, 25 Mar 2024 10:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388996; x=1711993796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l5fcOxFZ3SfmeC11WyIW95VQSKzd2HUl5BM/r+GzPq8=;
        b=WLZYPu9tpC5MklmOXHXa0fERCRCVT/GNnO1Ta3PRXr+u+AJL6lgrDvi0Xuc0zGMKUA
         o4iqNqUBT14wVKNeybY+jCPRR2l1+4LmbT9NfUjKpN16mN7kpp6BwBjq1wbgCjU9Nxnc
         XoywftRlb7IDDhiS3w/IQbDxl21gtanRIeTcTo1wpHF5PgNvPhS3DzoBcndqpNoCNuy0
         HYlU7j35FAkgIyNTU2C7zaBwWyKVU/yY4uMVkOKtPUW9wZggVCnNhULnCw0ANwDXaTuP
         HdMvSxaoZUlN7IBpu9iKialum2onNUNHkKU9J74oRt9YRg6EsmdW9g/p1B6HB2mu6V7M
         iWDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhZOHH1HUNofkU1QmgsVzU4hnAIbfTBrJkuNNpH8yQEHttfR6gQ8NaslmRMsJ0Y/yUdIBkV4g2stCyo2EMqKz625BL3HVBrfWHHwlQIWC5hKmUm2gwLq0n+BfkcZi9Y3PmGHIr+/fnmXSQ
X-Gm-Message-State: AOJu0Yyua3gKmTV/LkxzXu+8EAtwi0os82PzH/Zn5Lu3jmzxSKeHyo1K
	DMGY2AJnlmP00shDwruzNC0ldCL5x19cM+686/3YEq3NkU+u4IkNWqWdw8bw
X-Google-Smtp-Source: AGHT+IENgD8+x8qZmkV13905bfvd2FwS6j4oypicSxqZj+klTVmY22yKdServoEytD3nDpm3JPeuoQ==
X-Received: by 2002:a17:902:7b95:b0:1e0:939d:3d59 with SMTP id w21-20020a1709027b9500b001e0939d3d59mr617515pll.19.1711388995965;
        Mon, 25 Mar 2024 10:49:55 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id i6-20020a17090332c600b001e0abeb8fb5sm4129931plr.271.2024.03.25.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 10:49:54 -0700 (PDT)
Date: Mon, 25 Mar 2024 17:49:47 +0000
From: Wei Liu <wei.liu@kernel.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Wei Liu <wei.liu@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH] hv: vmbus: Convert sprintf() family to sysfs_emit()
 family
Message-ID: <ZgG5O3uO9JgOmU_Q@liuwe-devbox-debian-v2>
References: <20240319034350.1574454-1-lizhijian@fujitsu.com>
 <Zf4WUMyNq38LyDLW@liuwe-devbox-debian-v2>
 <5c1f6aba-bd3c-438c-8e00-548fe29d8136@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c1f6aba-bd3c-438c-8e00-548fe29d8136@fujitsu.com>

On Mon, Mar 25, 2024 at 09:39:52AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 23/03/2024 07:37, Wei Liu wrote:
> > Hi Zhijian,
> > 
> > On Tue, Mar 19, 2024 at 11:43:50AM +0800, Li Zhijian wrote:
> >> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> >> or sysfs_emit_at() when formatting the value to be returned to user space.
> >>
> >> coccinelle complains that there are still a couple of functions that use
> >> snprintf(). Convert them to sysfs_emit().
> >>
> >> sprintf() and scnprintf() will be converted as well if they have.
> > 
> > This sentence seems to have been cut off halfway. If they have what?
> 
> Is it hard to understand, what I want to say is:
> 
> Sprintf() and scnprintf() will be converted if these files have such abused cases.
> 
> Shall I update it and send a V2?

No need. I can fix up the commit message when I apply the patch. Thanks.

> 
> Thanks
> Zhijian
> 
> 
> 
> > 
> > The code looks fine.
> > 
> > Thanks,
> > Wei.

