Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AD3792A42
	for <lists+linux-hyperv@lfdr.de>; Tue,  5 Sep 2023 18:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240297AbjIEQei (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 5 Sep 2023 12:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354152AbjIEJ5o (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 5 Sep 2023 05:57:44 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659AC1AE
        for <linux-hyperv@vger.kernel.org>; Tue,  5 Sep 2023 02:57:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so901103e87.1
        for <linux-hyperv@vger.kernel.org>; Tue, 05 Sep 2023 02:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693907857; x=1694512657; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AKHR62ul+UyAMBBLZNZLoFrH8efwjpri67YRyIEqGb8=;
        b=ZM7D1UmPDfVFkSSO4UqZcDHdPUJVxtVWoKpFrg9rxoI0cQFhOlP0vjw7q3kBalQ/EZ
         F6UCW83dzlPQN4XyfMOlpe4nFgqLsDbKfzhjP1CGGY+MyrIqXsLq9FMjBqsU4DDbRZnr
         a9bmE4vOoB2APZkjtjBxV0+H35cYjQ9ZomvklF7I10LV6vRUA9OgYP2JDckETwzLeJep
         rVSGqiVLgMxatcZ4zWEuBe5OI7Vhe+6Qv3attJa6sxREpOAfdh59Y5JRV3TnDn0f8XIQ
         aY6Av2gK635lnE8nw43ojaYeQM7D3SEqhfH75kRNZuBkLy9IQoJPGg9+SAirYzM7EScr
         mRbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693907857; x=1694512657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AKHR62ul+UyAMBBLZNZLoFrH8efwjpri67YRyIEqGb8=;
        b=VxYYWNGDMAZTMYzXlHLBLbu7dKqWlQqTtEzG0F36tW67jwaVltm8aQEoY+vzsQocqF
         cqRUOPsG1qSP2T9RbXTblHrxzzJKVZzfbbdFeP12bfHQ4SbWyJ6LJniZEgrnv8D+bWjd
         S2rcMP0tf6Amu4HCQDAfZQ+4GyST/DdB0DmA3ULXwuwpyoHeODyVo1R6seglaMw3Opk1
         xbac9BF3VMnG04mXqn/3Cb3rf4/U3a6fmqWMXWMfM70Hq+zuEDInuj/vQroMRlLNoHYK
         qy9PiKBnFnqOIM3lJEEnM6a88+B98Iy9pZsSfcBqO8GNgQEEhIi9bQzVe4HzKGdcds6G
         RxZw==
X-Gm-Message-State: AOJu0Ywpv4PhnoPRP6t0Q1CAfr4ZaoKOHeLljHprbQ1kIna2FzPkg2ge
        yAIS9QI4ShuiwWLnBam3KxHqsA==
X-Google-Smtp-Source: AGHT+IF/Krv9XoaHXmgTX6hA95PT3mrsyeECELy7hFWygISVfjLi7nO3m0A/foR0u3zSojYLTMDlFA==
X-Received: by 2002:a19:8c09:0:b0:500:9d6c:913e with SMTP id o9-20020a198c09000000b005009d6c913emr7472258lfd.52.1693907857446;
        Tue, 05 Sep 2023 02:57:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4083000000b0031435731dfasm16913703wrp.35.2023.09.05.02.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 02:57:37 -0700 (PDT)
Date:   Tue, 5 Sep 2023 12:57:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ratheesh Kannoth <rkannoth@marvell.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, jiawenwu@trustnetic.com,
        mengyuanlou@net-swift.com, yang.lee@linux.alibaba.com,
        error27@gmail.com, linyunsheng@huawei.com,
        linux-hyperv@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, shradhagupta@linux.microsoft.com,
        linux-hwmon@vger.kernel.org, michael.chan@broadcom.com,
        richardcochran@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, nbd@nbd.name, john@phrozen.org,
        sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
        lorenzo@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
        linux-rdma@vger.kernel.org, saeedm@nvidia.com, leon@kernel.org,
        gerhard@engleder-embedded.com, maciej.fijalkowski@intel.com,
        alexanderduyck@fb.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
        xiaoning.wang@nxp.com, linux-imx@nxp.com, lgirdwood@gmail.com,
        broonie@kernel.org, jaswinder.singh@linaro.org,
        ilias.apalodimas@linaro.org, UNGLinuxDriver@microchip.com,
        horatiu.vultur@microchip.com, linux-omap@vger.kernel.org,
        grygorii.strashko@ti.com, simon.horman@corigine.com,
        vladimir.oltean@nxp.com, aleksander.lobakin@intel.com,
        linux-stm32@st-md-mailman.stormreply.com,
        alexandre.torgue@foss.st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, p.zabel@pengutronix.de,
        thomas.petazzoni@bootlin.com, mw@semihalf.com,
        sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, xen-devel@lists.xenproject.org,
        jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, shayne.chen@mediatek.com, kvalo@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH v1 net] page_pool: Cap queue size to 32k.
Message-ID: <75bcd331-9a62-486f-a15f-6aebf4d1838b@kadam.mountain>
References: <20230814060411.2401817-1-rkannoth@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814060411.2401817-1-rkannoth@marvell.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Aug 14, 2023 at 11:34:11AM +0530, Ratheesh Kannoth wrote:
> Clamp to 32k instead of returning error.

What is the motivation here?  What is the real world impact for the
users?

> 
> Please find discussion at
> https://lore.kernel.org/lkml/
> CY4PR1801MB1911E15D518A77535F6E51E2D308A@CY4PR1801MB1911.
> namprd18.prod.outlook.com/T/

Please don't break the URL up like this.  I think normally we would just
write up a normal commit message and use the Link: tag.

Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
Link: https://lore.kernel.org/lkml/CY4PR1801MB1911E15D518A77535F6E51E2D308A@CY4PR1801MB1911.namprd18.prod.outlook.com/
Signed-off-by:

> @@ -171,9 +171,10 @@ static int page_pool_init(struct page_pool *pool,
>  	if (pool->p.pool_size)
>  		ring_qsize = pool->p.pool_size;
>  
> -	/* Sanity limit mem that can be pinned down */
> +	/* Cap queue size to 32k */
>  	if (ring_qsize > 32768)
> -		return -E2BIG;
> +		ring_qsize = 32768;
> +
>  
>  	/* DMA direction is either DMA_FROM_DEVICE or DMA_BIDIRECTIONAL.

Don't introduce a blank line here.  Checkpatch will complain if you
have to blank lines in a row.  It won't complain about the patch but it
will complain if you apply the patch and then re-run checkpatch -f on
the file.  (I didn't test this but it's wrong either way. :P).

regards,
dan carpenter

