Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE518DEF7
	for <lists+linux-hyperv@lfdr.de>; Wed, 14 Aug 2019 22:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfHNUh0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 14 Aug 2019 16:37:26 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39402 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbfHNUhZ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 14 Aug 2019 16:37:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id f17so41582pfn.6
        for <linux-hyperv@vger.kernel.org>; Wed, 14 Aug 2019 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+VxcUkgMv5C6Owq6hhiGOKhlX0kBsP7MBfCttk6k1Us=;
        b=0IUppGsDxlHyQcKfLHuFd0H0tqux2bMDBNt+M9ss0PCKz5bACHobFhyOYp7Zj4EC1j
         9epvFIDrmlrsbzOUTkzM6YF/E8jZE/MKCPg1ByTtJ9FKnZJZPbOhafwVlAd1gARv0LnG
         IWcJuHoG0RxHuF0MnRIhMEMp2SRfyezE5FbAbKV/WLSJx2RdYZ70zDq3c+RoJpoq9EWh
         Wg5XNdDlCBBFnPig0ysqw4ZY7RW83xnu2TZFbBtry88P+W2HWhp1/hgX51AiuTONehOW
         bbaFLkj/CwBagVuF5Kip4D246zK0MK4Uy/dbMoEgmsAqRL7Qgqcc2Z+Trlftw6MYCaSA
         ZF0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+VxcUkgMv5C6Owq6hhiGOKhlX0kBsP7MBfCttk6k1Us=;
        b=HSCb/C3hSMFvuNurogu1hwx9vkzJo22hrOv6z0M+vQVe6p+qVEEqEnXHw6VzWYFpgq
         itKRAKy5wlWeOCi9tM6wHaLLo+4vB19Tr7Ox7U2wY3kH47mvk8P4Wh5EYkYcOy1HpWzm
         edlyxm/c+bRc+cEX9PC21YTbBxq6i6gsWIRXqi6d9gkYVMKreknxvHq0/UuLZJW2zLIm
         /wyyk6m+RY2nyRS0OyN2ij7Vp5ozjpLO/YQ9ddVZTRGAulHoktRmIcEBebrhtCSwzjy1
         rxHawG7Bbk50PUKguX6t/TZ0LA0DwunDfXNJrJBbhV2pcDZemw2rW5h3r8LK8ETfMlmQ
         AU9g==
X-Gm-Message-State: APjAAAUE7i5LbdZ3WHCVa40FJwvRawcU1tmCUC3CBJzFkQYgsdZKq/fW
        gXa561Qmd/xC+S7g1LFJIazfDA==
X-Google-Smtp-Source: APXvYqxcGm5E951PLcX5Ut7DOoqZwMC1w9WWE8vb6odAAJNKWlIxebVN7cf4TB5eKyp/1ueFj6wl2Q==
X-Received: by 2002:a63:e901:: with SMTP id i1mr777506pgh.451.1565815044726;
        Wed, 14 Aug 2019 13:37:24 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id u18sm767106pfl.29.2019.08.14.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 13:37:24 -0700 (PDT)
Date:   Wed, 14 Aug 2019 13:37:17 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-hyperv@vger.kernel.org (open list:Hyper-V CORE AND DRIVERS),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] hv_netvsc: Fix a memory leak bug
Message-ID: <20190814133717.4172033e@hermes.lan>
In-Reply-To: <1565813771-8967-1-git-send-email-wenwen@cs.uga.edu>
References: <1565813771-8967-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, 14 Aug 2019 15:16:11 -0500
Wenwen Wang <wenwen@cs.uga.edu> wrote:

> In rndis_filter_device_add(), 'rndis_device' is allocated through kzalloc()
> by invoking get_rndis_device(). In the following execution, if an error
> occurs, the execution will go to the 'err_dev_remv' label. However, the
> allocated 'rndis_device' is not deallocated, leading to a memory leak bug.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/net/hyperv/rndis_filter.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index 317dbe9..ed35085 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -1420,6 +1420,7 @@ struct netvsc_device *rndis_filter_device_add(struct hv_device *dev,
>  
>  err_dev_remv:
>  	rndis_filter_device_remove(dev, net_device);
> +	kfree(rndis_device);
>  	return ERR_PTR(ret);
>  }
>  

The rndis_device is already freed by:

rndis_filter_device_remove
	netvsc_device_remove
		free_netvsc_device_rcu

free_netvsc_device called by rcu

static void free_netvsc_device(struct rcu_head *head)
{
	struct netvsc_device *nvdev
		= container_of(head, struct netvsc_device, rcu);
	int i;

	kfree(nvdev->extension);  << here
