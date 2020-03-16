Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB7186E6A
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2020 16:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgCPPUx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Mar 2020 11:20:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34857 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729856AbgCPPUx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Mar 2020 11:20:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so1111829wru.2;
        Mon, 16 Mar 2020 08:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PHFwU/9Gwprc+RyvAszebJ6mggkLL/7mXQpDoqU9oeU=;
        b=jcedxD7NKQYDtUMcNkqQHGlt1H5Xpaw3RnwFUgSnatacPWrln81Dr9TIkc2965EqBm
         k1MYPg6psepbbXe/a1Iib0rl9LDLUgjd7+URVv1j0z6lHZruNfGkCobCLZoRC1oKug30
         JkxX8KSLmSiQsrhZm5ks0P0rOk4W2PxSEdtFGUXSQad1qvwjA+iEHqnL8XvmMECzwgCy
         5ttSoj635qpw+1LMdC14Y0Z3siW8lCCX9jOjkWXGvEzThd2CY1OBYYZFmJIrvxht+kJ+
         5tqX7lfnIwWKiz9GQ6ZwAXPDI86whLhO2AhY/hc8N1W4hKobiiYyw9YUvipOBg/7iK4u
         luCg==
X-Gm-Message-State: ANhLgQ2BCvWIVF6KN1GFZDMd8RrUa9+KpZF4iB39h4lEfAUIlmUj3Hb6
        qXYr94gLn0xrubpwkVZqhJs=
X-Google-Smtp-Source: ADFU+vuaSBhAghb7CaWtuVCz1nkuUiUyxqyZeuHdtukKOxs3qogmtqhAePyHD4CPFq9QAfjmqizbvA==
X-Received: by 2002:adf:db49:: with SMTP id f9mr15327113wrj.145.1584372051365;
        Mon, 16 Mar 2020 08:20:51 -0700 (PDT)
Received: from localhost ([37.188.132.163])
        by smtp.gmail.com with ESMTPSA id b187sm18218wmb.42.2020.03.16.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 08:20:50 -0700 (PDT)
Date:   Mon, 16 Mar 2020 16:20:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-hyperv@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: Re: [PATCH v1 3/5] drivers/base/memory: store mapping between MMOP_*
 and string in an array
Message-ID: <20200316152047.GU11482@dhcp22.suse.cz>
References: <20200311123026.16071-1-david@redhat.com>
 <20200311123026.16071-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311123026.16071-4-david@redhat.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed 11-03-20 13:30:24, David Hildenbrand wrote:
> Let's use a simple array which we can reuse soon. While at it, move the
> string->mmop conversion out of the device hotplug lock.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  drivers/base/memory.c | 38 +++++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index e7e77cafef80..8a7f29c0bf97 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -28,6 +28,24 @@
>  
>  #define MEMORY_CLASS_NAME	"memory"
>  
> +static const char *const online_type_to_str[] = {
> +	[MMOP_OFFLINE] = "offline",
> +	[MMOP_ONLINE] = "online",
> +	[MMOP_ONLINE_KERNEL] = "online_kernel",
> +	[MMOP_ONLINE_MOVABLE] = "online_movable",
> +};
> +
> +static int memhp_online_type_from_str(const char *str)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(online_type_to_str); i++) {
> +		if (sysfs_streq(str, online_type_to_str[i]))
> +			return i;
> +	}
> +	return -EINVAL;
> +}
> +
>  #define to_memory_block(dev) container_of(dev, struct memory_block, dev)
>  
>  static int sections_per_block;
> @@ -236,26 +254,17 @@ static int memory_subsys_offline(struct device *dev)
>  static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>  			   const char *buf, size_t count)
>  {
> +	const int online_type = memhp_online_type_from_str(buf);
>  	struct memory_block *mem = to_memory_block(dev);
> -	int ret, online_type;
> +	int ret;
> +
> +	if (online_type < 0)
> +		return -EINVAL;
>  
>  	ret = lock_device_hotplug_sysfs();
>  	if (ret)
>  		return ret;
>  
> -	if (sysfs_streq(buf, "online_kernel"))
> -		online_type = MMOP_ONLINE_KERNEL;
> -	else if (sysfs_streq(buf, "online_movable"))
> -		online_type = MMOP_ONLINE_MOVABLE;
> -	else if (sysfs_streq(buf, "online"))
> -		online_type = MMOP_ONLINE;
> -	else if (sysfs_streq(buf, "offline"))
> -		online_type = MMOP_OFFLINE;
> -	else {
> -		ret = -EINVAL;
> -		goto err;
> -	}
> -
>  	switch (online_type) {
>  	case MMOP_ONLINE_KERNEL:
>  	case MMOP_ONLINE_MOVABLE:
> @@ -271,7 +280,6 @@ static ssize_t state_store(struct device *dev, struct device_attribute *attr,
>  		ret = -EINVAL; /* should never happen */
>  	}
>  
> -err:
>  	unlock_device_hotplug();
>  
>  	if (ret < 0)
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
