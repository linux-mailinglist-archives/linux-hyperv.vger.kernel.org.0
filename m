Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67EB81B69A4
	for <lists+linux-hyperv@lfdr.de>; Fri, 24 Apr 2020 01:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbgDWXZR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Apr 2020 19:25:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45665 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgDWXZR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Apr 2020 19:25:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id w65so3819174pfc.12;
        Thu, 23 Apr 2020 16:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=nXwzG0UZc6KKxJD7f9w5S9le9tHn88lTbuq8NDnlIcE=;
        b=iyaeXlk1SeJrW0VOAK03cYweH2PEmsvTkfNZYi3jKT2NYujxq7vUkOzpizurG/9FUn
         nwaTQYqpPLVrxyrCW0VXmxA+p4ENGE0xfcMBC6cK5rEU+rMFcIaRG7PRI68FNnIaIjzk
         NZO6JJETxx1yWPiqEWr1sdTyWmnvMY2BAx1xWDbU5faIBYlIvUv7EB1YSFYCunYSbMup
         kfm+kkbe0275OymBEPi/CLB6N4cCsMiJXyV8A1HQxJrsEZd5G50QZz6ZHujy5EktVdFb
         WrEVkne+sbWx3ZH2/PS4zdxMslLFGyTj/fEArENlOe74YtCsz6WkJqdF8ahkFsx6ncUy
         Vp7A==
X-Gm-Message-State: AGi0PuaZD+3oUPSNlpubSmQww3cTQ+1GXgsaVD8XH7zaiSNmuGOkHcmg
        w/7QxO/MYbK6YEM9ZSw6R3A=
X-Google-Smtp-Source: APiQypKxsNXbiiRHX+Hm3WgB++Uo+jvnCWaXXvhtNGpfZ9YuxZGolRkGPH+2YkNX6KP7I5WB1V6qgQ==
X-Received: by 2002:a63:9701:: with SMTP id n1mr5964142pge.19.1587684315425;
        Thu, 23 Apr 2020 16:25:15 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:30fe:750:6059:a44d? ([2601:647:4000:d7:30fe:750:6059:a44d])
        by smtp.gmail.com with ESMTPSA id u2sm3299740pjn.20.2020.04.23.16.25.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 16:25:14 -0700 (PDT)
Subject: Re: [PATCH] scsi: storvsc: Fix a panic in the hibernation procedure
To:     Dexuan Cui <decui@microsoft.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "hare@suse.de" <hare@suse.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        Balsundar P <Balsundar.P@microchip.com>
Cc:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>
References: <1587514644-47058-1-git-send-email-decui@microsoft.com>
 <1b6de3b0-4e0c-4b46-df1a-db531bd2c888@acm.org>
 <HK0P153MB027395755C14233F09A8F352BFD20@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <c55d643c-c13f-70f1-7a44-608f94fbfd5f@acm.org>
 <HK0P153MB02737524F120829405C6DE68BFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
 <ade7f096-4a09-4d4e-753a-f9e4acb7b550@acm.org>
 <HK0P153MB02731F9C5FC61C466715362CBFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
From:   Bart Van Assche <bvanassche@acm.org>
Autocrypt: addr=bvanassche@acm.org; prefer-encrypt=mutual; keydata=
 mQENBFSOu4oBCADcRWxVUvkkvRmmwTwIjIJvZOu6wNm+dz5AF4z0FHW2KNZL3oheO3P8UZWr
 LQOrCfRcK8e/sIs2Y2D3Lg/SL7qqbMehGEYcJptu6mKkywBfoYbtBkVoJ/jQsi2H0vBiiCOy
 fmxMHIPcYxaJdXxrOG2UO4B60Y/BzE6OrPDT44w4cZA9DH5xialliWU447Bts8TJNa3lZKS1
 AvW1ZklbvJfAJJAwzDih35LxU2fcWbmhPa7EO2DCv/LM1B10GBB/oQB5kvlq4aA2PSIWkqz4
 3SI5kCPSsygD6wKnbRsvNn2mIACva6VHdm62A7xel5dJRfpQjXj2snd1F/YNoNc66UUTABEB
 AAG0JEJhcnQgVmFuIEFzc2NoZSA8YnZhbmFzc2NoZUBhY20ub3JnPokBOQQTAQIAIwUCVI67
 igIbAwcLCQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEHFcPTXFzhAJ8QkH/1AdXblKL65M
 Y1Zk1bYKnkAb4a98LxCPm/pJBilvci6boefwlBDZ2NZuuYWYgyrehMB5H+q+Kq4P0IBbTqTa
 jTPAANn62A6jwJ0FnCn6YaM9TZQjM1F7LoDX3v+oAkaoXuq0dQ4hnxQNu792bi6QyVdZUvKc
 macVFVgfK9n04mL7RzjO3f+X4midKt/s+G+IPr4DGlrq+WH27eDbpUR3aYRk8EgbgGKvQFdD
 CEBFJi+5ZKOArmJVBSk21RHDpqyz6Vit3rjep7c1SN8s7NhVi9cjkKmMDM7KYhXkWc10lKx2
 RTkFI30rkDm4U+JpdAd2+tP3tjGf9AyGGinpzE2XY1K5AQ0EVI67igEIAKiSyd0nECrgz+H5
 PcFDGYQpGDMTl8MOPCKw/F3diXPuj2eql4xSbAdbUCJzk2ETif5s3twT2ER8cUTEVOaCEUY3
 eOiaFgQ+nGLx4BXqqGewikPJCe+UBjFnH1m2/IFn4T9jPZkV8xlkKmDUqMK5EV9n3eQLkn5g
 lco+FepTtmbkSCCjd91EfThVbNYpVQ5ZjdBCXN66CKyJDMJ85HVr5rmXG/nqriTh6cv1l1Js
 T7AFvvPjUPknS6d+BETMhTkbGzoyS+sywEsQAgA+BMCxBH4LvUmHYhpS+W6CiZ3ZMxjO8Hgc
 ++w1mLeRUvda3i4/U8wDT3SWuHcB3DWlcppECLkAEQEAAYkBHwQYAQIACQUCVI67igIbDAAK
 CRBxXD01xc4QCZ4dB/0QrnEasxjM0PGeXK5hcZMT9Eo998alUfn5XU0RQDYdwp6/kMEXMdmT
 oH0F0xB3SQ8WVSXA9rrc4EBvZruWQ+5/zjVrhhfUAx12CzL4oQ9Ro2k45daYaonKTANYG22y
 //x8dLe2Fv1By4SKGhmzwH87uXxbTJAUxiWIi1np0z3/RDnoVyfmfbbL1DY7zf2hYXLLzsJR
 mSsED/1nlJ9Oq5fALdNEPgDyPUerqHxcmIub+pF0AzJoYHK5punqpqfGmqPbjxrJLPJfHVKy
 goMj5DlBMoYqEgpbwdUYkH6QdizJJCur4icy8GUNbisFYABeoJ91pnD4IGei3MTdvINSZI5e
Message-ID: <f23cb660-13e4-8466-4c78-163fcc857caa@acm.org>
Date:   Thu, 23 Apr 2020 16:25:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <HK0P153MB02731F9C5FC61C466715362CBFD30@HK0P153MB0273.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 2020-04-23 11:29, Dexuan Cui wrote:
> So it looks the below patch also works for me:
> 
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -898,6 +898,11 @@ static int software_resume(void)
>         error = freeze_processes();
>         if (error)
>                 goto Close_Finish;
> +
> +       error = freeze_kernel_threads();
> +       if (error)
> +               goto Close_Finish;
> +
>         error = load_image_and_restore();
>         thaw_processes();
>   Finish:
> 
> Just to be sure, I'll do more tests, but I believe the panic can be fixed
> by this according to my tests I have done so far.

If a freeze_kernel_threads() call is added in software_resume(), should
a thaw_kernel_threads() call be added too?

Anyway, please Cc me if a patch for software_resume() is submitted.

> I'm still not sure what the comment before scsi_device_quiesce() means:
>  *  ... Since special requests may also be requeued requests,
>  *      a successful return doesn't guarantee the device will be
>  *      totally quiescent.
> 
> I don't know if there can be some other I/O submitted after
> scsi_device_quiesce() returns in the case of hibernation, and I don't
> know if aac_suspend() -> scsi_host_block() should be fixed/removed,
> but as far as the panic is concerned, I'm very glad I have found a better
> fix with your help. 

The function blk_set_pm_only() increments the q->pm_only counter while
the blk_clear_pm_only() function decrements the q->pm_only counter.
If q->pm_only > 0, blk_queue_enter() only succeeds if the flag
BLK_MQ_REQ_PREEMPT is set in the second argument passed to that
function. blk_get_request() calls blk_queue_enter(). The result is that
while q->pm_only > 0 blk_get_request() only submits a request without
waiting if the BLK_MQ_REQ_PREEMPT flag is set in its second argument.
scsi_execute() sets the BLK_MQ_REQ_PREEMPT flag. In other words,
scsi_device_quiesce() blocks requests submitted by filesystems but still
allows SCSI commands submitted by the SCSI core to be executed.
"special" refers to requests with the BLK_MQ_REQ_PREEMPT flag set.

Bart.
