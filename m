Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FDE77B44F
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 10:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbjHNIkp (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 04:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjHNIkM (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 04:40:12 -0400
X-Greylist: delayed 2603 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 01:40:10 PDT
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD1FBF;
        Mon, 14 Aug 2023 01:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=2P1CtK0EpHYNB0bkUEbNbkfg4BjOcYJ3BMKesAvDyvc=;
        t=1692002410; x=1693212010; b=b+lgM10B1Ch71jXvK0waAeTapoeUIh1e1FLcgFiR3ksab1x
        01x3rbg8flpkCpRWXbk6srcmQmZEEXG4S/84J8KtgtEf7Z+qbAjBDdtigVXjxrTu1n8ckaze/cddn
        Ju5e9frlbN1K2Nq7H8Lx2q5l1V+ePpa7pkoyDSa14USbLK3ogWvZNWOoD7Kl/kmVmTlv4HkbPl+Rm
        2WnwtHNTMJMmU4pK56Sv2qR1jD1wm143bkG3ErhIhPlZtRItZ8nTHhAtZlq1Ef053aYIPwEK81qII
        ECxyiiYrv7BxdMwt7F+Wz87khGXXDipoS6smf8cvm8Jlb29EbFy2sgfkB/jUjJNA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qVSQ8-006VTj-1d;
        Mon, 14 Aug 2023 09:55:24 +0200
Message-ID: <8c6d19da5c4c38062b7a4e500de1d5dc1280fbc8.camel@sipsolutions.net>
Subject: Re: [PATCH v1 net] page_pool: Cap queue size to 32k.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
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
Date:   Mon, 14 Aug 2023 09:54:56 +0200
In-Reply-To: <20230814060411.2401817-1-rkannoth@marvell.com>
References: <20230814060411.2401817-1-rkannoth@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 2023-08-14 at 11:34 +0530, Ratheesh Kannoth wrote:
> Clamp to 32k instead of returning error.
>=20
> Please find discussion at
> https://lore.kernel.org/lkml/
> CY4PR1801MB1911E15D518A77535F6E51E2D308A@CY4PR1801MB1911.
> namprd18.prod.outlook.com/T/
>=20

I'm not the one who's going to apply this, but honestly, I don't think
that will work as a commit message for such a change ...

Sure, link to it by all means, but also summarize it and make sense of
it for the commit message?

johannes
