Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5756F5A37DF
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Aug 2022 15:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbiH0NTj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 27 Aug 2022 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiH0NTi (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 27 Aug 2022 09:19:38 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B587198A;
        Sat, 27 Aug 2022 06:19:37 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MFHJc4yxCzkWV9;
        Sat, 27 Aug 2022 21:16:00 +0800 (CST)
Received: from dggpemm500002.china.huawei.com (7.185.36.229) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 21:19:35 +0800
Received: from [10.174.178.247] (10.174.178.247) by
 dggpemm500002.china.huawei.com (7.185.36.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 21:19:34 +0800
Subject: Re: [PATCH v2 5/5] ACPI: Drop parent field from struct acpi_device
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Mark Brown <broonie@kernel.org>,
        "Andreas Noever" <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        <linux-hyperv@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, "Will Deacon" <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>
References: <12036348.O9o76ZdvQC@kreacher> <2196460.iZASKD2KPV@kreacher>
 <5857822.lOV4Wx5bFT@kreacher>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <a0cab176-3c3a-707a-02c3-74ffc1b4926e@huawei.com>
Date:   Sat, 27 Aug 2022 21:19:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5857822.lOV4Wx5bFT@kreacher>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.247]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500002.china.huawei.com (7.185.36.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Rafael,

On 2022/8/25 0:59, Rafael J. Wysocki wrote:
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -365,7 +365,6 @@ struct acpi_device {
>   	int device_type;
>   	acpi_handle handle;		/* no handle for fixed hardware */
>   	struct fwnode_handle fwnode;
> -	struct acpi_device *parent;
>   	struct list_head wakeup_list;
>   	struct list_head del_list;
>   	struct acpi_device_status status;
> @@ -458,6 +457,14 @@ static inline void *acpi_driver_data(str
>   #define to_acpi_device(d)	container_of(d, struct acpi_device, dev)
>   #define to_acpi_driver(d)	container_of(d, struct acpi_driver, drv)
>   
> +static inline struct acpi_device *acpi_dev_parent(struct acpi_device *adev)
> +{
> +	if (adev->dev.parent)
> +		return to_acpi_device(adev->dev.parent);
> +
> +	return NULL;
> +}
> +
>   static inline void acpi_set_device_status(struct acpi_device *adev, u32 sta)
>   {
>   	*((u32 *)&adev->status) = sta;
> @@ -478,6 +485,7 @@ void acpi_initialize_hp_context(struct a
>   /* acpi_device.dev.bus == &acpi_bus_type */
>   extern struct bus_type acpi_bus_type;
>   
> +struct acpi_device *acpi_dev_parent(struct acpi_device *adev);

We have a static inline function above, is it duplicated here?
Or did I miss some use cases?

Thanks
Hanjun
