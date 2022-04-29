Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3190051494F
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Apr 2022 14:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357747AbiD2MdG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 29 Apr 2022 08:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237055AbiD2MdF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 29 Apr 2022 08:33:05 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D3BC8BF2;
        Fri, 29 Apr 2022 05:29:46 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220429122943euoutp01458b2a0ffc4189ccec75d50d7637d3e8~qXdUa8Cam0628106281euoutp01T;
        Fri, 29 Apr 2022 12:29:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220429122943euoutp01458b2a0ffc4189ccec75d50d7637d3e8~qXdUa8Cam0628106281euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651235383;
        bh=BLy6dEdd66oc6iIL1UsBH6ZK/p3m9vCFckbreG6yqyQ=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=H9r0wEis0WrtASo5RyQXYHFRUTSdogCLsXPkdtG3fp0K7D5YDo0Aq9cVaNAgN+1Ow
         t7G/IgyPBabntnsaQ3dmmDK9Y8UGWmyFrhJO3IsWJA7XHfitFLRD4coALiLCtII/1X
         R+pdVDRPZ/bu2LZZhq5+KAKn5+NQquHd/tg4cacc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220429122942eucas1p1d34d92cccbe0941ec1bd689c3295e213~qXdUJ3mq70545905459eucas1p1o;
        Fri, 29 Apr 2022 12:29:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 32.F2.10260.63ADB626; Fri, 29
        Apr 2022 13:29:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9~qXdTndi5b0970909709eucas1p1W;
        Fri, 29 Apr 2022 12:29:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220429122942eusmtrp1e50bcb5c9efcd5d86ebcc963f0f23ff4~qXdTj0jhn2535925359eusmtrp16;
        Fri, 29 Apr 2022 12:29:42 +0000 (GMT)
X-AuditID: cbfec7f5-bf3ff70000002814-b7-626bda365cbd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 86.52.09404.63ADB626; Fri, 29
        Apr 2022 13:29:42 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220429122940eusmtip1946211aaf83d463f473b3f56f8be6032~qXdRsQjxU2403924039eusmtip14;
        Fri, 29 Apr 2022 12:29:40 +0000 (GMT)
Message-ID: <870885de-33f3-e0ba-4d56-71c3c993ac87@samsung.com>
Date:   Fri, 29 Apr 2022 14:29:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v7 12/12] rpmsg: Fix kfree() of static memory on setting
 driver_override
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20220419113435.246203-13-krzysztof.kozlowski@linaro.org>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHc3ov95ZuZZcC4wyYbHWS7AFMGeYkKnMw5UbNokTZMhNHgSsg
        FEgLqGSJjIobFVkpYqXyFnm7QhGGD15FgVFhDLZOsBKk3RbsSmxAEx4lo73Zxj8nn/M939/5
        /b4nh4sJHhI+3KTUDEaSKkoREjy8c3B5LHDndHLsh/bGHahNP0+gMdMqjn79RcdB84oBgGpz
        E5G+dwFHJruOQD3ntQCNq1+6INl1DYEMP9LIUtEEULelg0Tm5o1FazK4oKLeURLZCmZcUEnR
        cwLJVxoxNHmnjECjFUMEkv0sRIpqGYa+sU2RyKSuIFDHvT4OGjE+Aah8qQRD1oF+DPW3TWOo
        TnOTRHOFVhLVj274lAN1LmhAO83Zu5VuXcwl6NvqJyRdpc2ktU35BG003CPo4aurOK2o6QN0
        b3kLSbfXnqOLH9UDOq/LTtJtC10celyeTC9qtxx2+5K3O55JScpiJMFhMbxEW+FtIl3xwZmZ
        kVY8B9S+IweuXEh9BEc07aSDBVQDgD2XoBzwNngJwBcll3H2YBFA5S1KDrjOgpWVw6ynHsCq
        Gws4u7EBWPa03lnAp8Lgg8UrhINxahtsVv2Jsbo7/KnU7PR4UbGwvGfGqXtQJ2Df4xaOgzHK
        G06bK53sSV0G8MZ8KKvrXeFkL+1ggtoO5Va5835Xaj+8rqzGWI8/lHVcwxwDQcrMg+v1VQQb
        81NoKl3DWfaAz4ZukSz7QX1xAc4mS4P2qyGsfAYaLC0Yy7ugcWyFcFgw6l2ouRPMyp/AuqVC
        DlvpBh9Z3dkJ3KCyU4WxMh9+d0HAugOgeuiH/3r2j09gCiBUb3oT9abs6k1Z1P/3rQJ4E/Bm
        MqXiBEYaksqcDpKKxNLM1ISguDSxFmx8eP360Isu0PDMFqQDHC7QAcjFhJ78pbuJsQJ+vOhs
        NiNJ+0qSmcJIdcCXiwu9+XFJrSIBlSDKYJIZJp2R/HvK4br65HA8sZqosLk3ooOb88Orj0lP
        +goCldROXs3FtaFjDduW8xq6s1+78NaRXc/dsuJiJ2aiK/xenZr1OLh8vLEgRst/Ohhj3Hqy
        dNhPEnJ8LcBwZP39yYy+c6uJ+6OOvjQoj87mnl2e1Z34IvRATnDUXouQii7w/3ukLHKP8KEp
        e7Cyrs5sj7eOPI5QvD0eWZwkQbsPhmuv/Pb76Jb75ozTKk1ZZQR4U5yNSw5lkSGVEd8Of2/x
        9RlU1Ri8VC3dXvmBPuEx6aUySgyVp/ZNEV4HJv7yv+l1KiAm+us/Pi93P9Su7t8T0LhedH7f
        JCH+7Np0pMF46ZX7itc7RQ+SLn6ctxS6g567K8SliaLt72ESqegfQlmaV18EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsVy+t/xu7pmt7KTDA6/4rHYePolm8W5x79Z
        LK5cPMRk8XLCYUaLJU0ZFqf3v2OxePz3EJvFvpZNjBYXZn1jtWhevJ7N4tp2D4vX81YxWux9
        vZXd4slqILHp8TVWi4n7z7JbfOy5x2oxdeIHNouuXyuZLS7vmsNmcXbecTaL5vNKFhMWNjNb
        NH68yW7xeNY8Noutew4wWZy6c5fRYu6XqcwWbw8fZLY4uPEWs8Wy9WvZLR71vWW3WH4WqG7S
        4WWsFoc33WJyUPbY8LmJzWPnrLvsHgs2lXpsWtXJ5nHn2h42jxMzfrN4TFh0gNFj/9w17B6b
        l9R7TL6xnNGjdcdfdo+N73YweVzoyvb4vEkugC9Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/I
        xFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+Nj3062ggk6FfdObWBpYFyi0sXIwSEhYCLx61dA
        FyMXh5DAUkaJmZ0NrF2MnEBxGYmT02BsYYk/17rYIIreM0q09N0CS/AK2Ekc/TyNDcRmEVCV
        WD39GTNEXFDi5MwnLCC2qECSxIttzxlBbGGBOIkDt9cwgdjMAuISt57MZwIZKiIwjVHiUcMZ
        FojERU6Jy/sSILY1MEpM7LgLNpVNwFCi620X2DZOATeJxZMWMkM0mEl0be1ihLDlJZq3zmae
        wCg0C8khs5AsnIWkZRaSlgWMLKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECk9u2Yz+37GBc
        +eqj3iFGJg7GQ4wSHMxKIrxfdmckCfGmJFZWpRblxxeV5qQWH2I0BYbGRGYp0eR8YHrNK4k3
        NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpg0uc+eIGt9+u5ab5OJkdU
        9rrqsvakOobVTZQxW53858w5vQOR166LqqVZf5x9f3n6SdOQeW0RSbIVF41Xr1uXVih5yaLB
        Qmar2Yn5ynsOsjduLGDQZtyvmrX/n4TIsjNXr6Zr/9GYs+0417m4J7e6l+u5xEkwpDn/6H9X
        nZinltPNXxn8ZGrc1WCxiwtK/8QtLFGr/7+do+GoanbazNPc7Me5j57k+p16e5LvpIVZ5W4r
        rkidvm3281DQwsc2Uze1qMRkOkdqsAj+WP7hb0rBvPrOb7q/1jYt9nh3fa9WesjfmTt8dEzT
        Ve3tz/D78y1wOsD1YolUY8yNCNuzDwxl7k7dold5+tiZjK4L7saBSizFGYmGWsxFxYkAlCo5
        wvcDAAA=
X-CMS-MailID: 20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
        <20220419113435.246203-13-krzysztof.kozlowski@linaro.org>
        <CGME20220429122942eucas1p1820d0cd17a871d4953bac2b3de1dcdd9@eucas1p1.samsung.com>
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Krzysztof,

On 19.04.2022 13:34, Krzysztof Kozlowski wrote:
> The driver_override field from platform driver should not be initialized
> from static memory (string literal) because the core later kfree() it,
> for example when driver_override is set via sysfs.
>
> Use dedicated helper to set driver_override properly.
>
> Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

This patch landed recently in linux-next as commit 42cd402b8fd4 ("rpmsg: 
Fix kfree() of static memory on setting driver_override"). In my tests I 
found that it triggers the following issue during boot of the 
DragonBoard410c SBC (arch/arm64/boot/dts/qcom/apq8016-sbc.dtb):

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 8 at kernel/locking/mutex.c:582 
__mutex_lock+0x1ec/0x430
Modules linked in:
CPU: 1 PID: 8 Comm: kworker/u8:0 Not tainted 5.18.0-rc4-next-20220429 #11815
Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock+0x1ec/0x430
lr : __mutex_lock+0x1ec/0x430
..
Call trace:
  __mutex_lock+0x1ec/0x430
  mutex_lock_nested+0x38/0x64
  driver_set_override+0x124/0x150
  qcom_smd_register_edge+0x2a8/0x4ec
  qcom_smd_probe+0x54/0x80
  platform_probe+0x68/0xe0
  really_probe.part.0+0x9c/0x29c
  __driver_probe_device+0x98/0x144
  driver_probe_device+0xac/0x14c
  __device_attach_driver+0xb8/0x120
  bus_for_each_drv+0x78/0xd0
  __device_attach+0xd8/0x180
  device_initial_probe+0x14/0x20
  bus_probe_device+0x9c/0xa4
  deferred_probe_work_func+0x88/0xc4
  process_one_work+0x288/0x6bc
  worker_thread+0x248/0x450
  kthread+0x118/0x11c
  ret_from_fork+0x10/0x20
irq event stamp: 3599
hardirqs last  enabled at (3599): [<ffff80000919053c>] 
_raw_spin_unlock_irqrestore+0x98/0x9c
hardirqs last disabled at (3598): [<ffff800009190ba4>] 
_raw_spin_lock_irqsave+0xc0/0xcc
softirqs last  enabled at (3554): [<ffff800008010470>] _stext+0x470/0x5e8
softirqs last disabled at (3549): [<ffff8000080a4514>] 
__irq_exit_rcu+0x180/0x1ac
---[ end trace 0000000000000000 ]---

I don't see any direct relation between the $subject and the above log, 
but reverting the $subject on top of linux next-20220429 hides/fixes it. 
Maybe there is a kind of memory trashing somewhere there and your change 
only revealed it?

> ---
>   drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
>   drivers/rpmsg/rpmsg_ns.c       | 14 ++++++++++++--
>   include/linux/rpmsg.h          |  6 ++++--
>   3 files changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
> index d4b23fd019a8..3e81642238d2 100644
> --- a/drivers/rpmsg/rpmsg_internal.h
> +++ b/drivers/rpmsg/rpmsg_internal.h
> @@ -94,10 +94,19 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
>    */
>   static inline int rpmsg_ctrldev_register_device(struct rpmsg_device *rpdev)
>   {
> +	int ret;
> +
>   	strcpy(rpdev->id.name, "rpmsg_ctrl");
> -	rpdev->driver_override = "rpmsg_ctrl";
> +	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
> +				  rpdev->id.name, strlen(rpdev->id.name));
> +	if (ret)
> +		return ret;
> +
> +	ret = rpmsg_register_device(rpdev);
> +	if (ret)
> +		kfree(rpdev->driver_override);
>   
> -	return rpmsg_register_device(rpdev);
> +	return ret;
>   }
>   
>   #endif
> diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
> index 762ff1ae279f..8eb8f328237e 100644
> --- a/drivers/rpmsg/rpmsg_ns.c
> +++ b/drivers/rpmsg/rpmsg_ns.c
> @@ -20,12 +20,22 @@
>    */
>   int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
>   {
> +	int ret;
> +
>   	strcpy(rpdev->id.name, "rpmsg_ns");
> -	rpdev->driver_override = "rpmsg_ns";
> +	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
> +				  rpdev->id.name, strlen(rpdev->id.name));
> +	if (ret)
> +		return ret;
> +
>   	rpdev->src = RPMSG_NS_ADDR;
>   	rpdev->dst = RPMSG_NS_ADDR;
>   
> -	return rpmsg_register_device(rpdev);
> +	ret = rpmsg_register_device(rpdev);
> +	if (ret)
> +		kfree(rpdev->driver_override);
> +
> +	return ret;
>   }
>   EXPORT_SYMBOL(rpmsg_ns_register_device);
>   
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 02fa9116cd60..20c8cd1cde21 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -41,7 +41,9 @@ struct rpmsg_channel_info {
>    * rpmsg_device - device that belong to the rpmsg bus
>    * @dev: the device struct
>    * @id: device id (used to match between rpmsg drivers and devices)
> - * @driver_override: driver name to force a match
> + * @driver_override: driver name to force a match; do not set directly,
> + *                   because core frees it; use driver_set_override() to
> + *                   set or clear it.
>    * @src: local address
>    * @dst: destination address
>    * @ept: the rpmsg endpoint of this channel
> @@ -51,7 +53,7 @@ struct rpmsg_channel_info {
>   struct rpmsg_device {
>   	struct device dev;
>   	struct rpmsg_device_id id;
> -	char *driver_override;
> +	const char *driver_override;
>   	u32 src;
>   	u32 dst;
>   	struct rpmsg_endpoint *ept;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

