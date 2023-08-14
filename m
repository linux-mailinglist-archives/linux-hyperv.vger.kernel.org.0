Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3068877B4F3
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 11:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbjHNJAb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 05:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236739AbjHNI7p (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 04:59:45 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B732359C;
        Mon, 14 Aug 2023 01:58:31 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E7juZ7011729;
        Mon, 14 Aug 2023 01:55:20 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sfg1pr6ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 01:55:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkAZ+W/lcO2EAbCs+P1+p0m2cT6KHZyIW9nZUfVtZj/yaS9kX9fSSriJKG/5O/QOcVUMf2bvp3SbKWdDKsqeXozU3PVl+IfSV8M97QmAtTrGW6SHpoNM4B8c17OkUp7+yvNpY2Z0XXTwGgOu8eha4AEwLW9cYQQgm53GOwaEgPRNENBpvkE1+NydQ//wGFXSaogGO1jyBAyphFRsPVRZZE0M2dEtBs7tyZmNK37WZr92CMAzQi6u/jmIAKCook2OxirPB06tMDUA4HcAi/Eu/Nj9BwwD3FPS9A7HXHIu3zY4RItWtE9v798pRFGlhSAx8rvAry+L7LHKy7p/o+g/9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pKlbzCrY1DtBhUGV1M+DO81GolN0fk0rkI9WgvE6w74=;
 b=JfejF8wIyOlLVvzz3JYixBaVKCVBDmLM5W7mwwcVGxCrZcGAVbI4CLhmamy1KHljPqgL2M/wG4H14D4G51vNmjWYx4/yNq2DtcHSQ+T/g1YU6y7q52Z+EZnDwEjRlIxNVEDTuTBFevSKsdD9Rj16Y8yXgGwL9cKw7XogRZplbfpYvTQbj01/wMAWiKvGHucuyLIZQnpyAeO7cpV/pJm4BysfbcJ7wcbk7RPPgDPVdpqLktWQodPltG1ympFoEBD+NOwB/vKSTlqN0fqxhQLFITKYdVTB6qFhG8StD5xMGiNB2w6Z7F/01pbUa0v6f7ogDoQLYwOdRnuTHggJyLzFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pKlbzCrY1DtBhUGV1M+DO81GolN0fk0rkI9WgvE6w74=;
 b=cEN1Mlb9YziNR8pu0Zx5zNgYERC4KvFlvhFb2F07Bz7dfoZ8a8WdcjvTGpp8ZALUYiK4pqvlEci5MfmAvJyM9ToQV1MFCXSBOg4C/p+9YiMhNJbYHbSujI1R5DdMFGZ7wPP7crr/5Cft6HseQPdxL/6Wk6qMklhX/he+1pdKmtY=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by BN9PR18MB4218.namprd18.prod.outlook.com
 (2603:10b6:408:137::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 08:55:15 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::9ee9:35fc:cabe:11a1]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::9ee9:35fc:cabe:11a1%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:55:15 +0000
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "jiawenwu@trustnetic.com" <jiawenwu@trustnetic.com>,
        "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
        "error27@gmail.com" <error27@gmail.com>,
        "linyunsheng@huawei.com" <linyunsheng@huawei.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "longli@microsoft.com" <longli@microsoft.com>,
        "shradhagupta@linux.microsoft.com" <shradhagupta@linux.microsoft.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nbd@nbd.name" <nbd@nbd.name>,
        "john@phrozen.org" <john@phrozen.org>,
        "sean.wang@mediatek.com" <sean.wang@mediatek.com>,
        "Mark-MC.Lee@mediatek.com" <Mark-MC.Lee@mediatek.com>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "saeedm@nvidia.com" <saeedm@nvidia.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "gerhard@engleder-embedded.com" <gerhard@engleder-embedded.com>,
        "maciej.fijalkowski@intel.com" <maciej.fijalkowski@intel.com>,
        "alexanderduyck@fb.com" <alexanderduyck@fb.com>,
        "wei.fang@nxp.com" <wei.fang@nxp.com>,
        "shenwei.wang@nxp.com" <shenwei.wang@nxp.com>,
        "xiaoning.wang@nxp.com" <xiaoning.wang@nxp.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "yisen.zhuang@huawei.com" <yisen.zhuang@huawei.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "horatiu.vultur@microchip.com" <horatiu.vultur@microchip.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "grygorii.strashko@ti.com" <grygorii.strashko@ti.com>,
        "simon.horman@corigine.com" <simon.horman@corigine.com>,
        "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
        "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "mw@semihalf.com" <mw@semihalf.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        Geethasowjanya Akula <gakula@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "jgross@suse.com" <jgross@suse.com>,
        "sstabellini@kernel.org" <sstabellini@kernel.org>,
        "oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ryder.lee@mediatek.com" <ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com" <shayne.chen@mediatek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>
Subject: RE: [EXT] Re: [PATCH v1 net] page_pool: Cap queue size to 32k.
Thread-Topic: [EXT] Re: [PATCH v1 net] page_pool: Cap queue size to 32k.
Thread-Index: AQHZznU+ZcDNaqRkgEScX+JwHjZ6da/pbFAAgAAB4aCAAAxOAIAAARQQ
Date:   Mon, 14 Aug 2023 08:55:14 +0000
Message-ID: <MWHPR1801MB19182915C64A7C7611F326F7D317A@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20230814060411.2401817-1-rkannoth@marvell.com>
 <8c6d19da5c4c38062b7a4e500de1d5dc1280fbc8.camel@sipsolutions.net>
 <MWHPR1801MB1918230E007D7B2C5A768B37D317A@MWHPR1801MB1918.namprd18.prod.outlook.com>
 <cceef8a4-6f38-bfd4-4f77-5dffa558b287@kernel.org>
In-Reply-To: <cceef8a4-6f38-bfd4-4f77-5dffa558b287@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY210aGJtNXZkR2hjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAwTmpjd05XUTRPQzB6WVRnd0xURXhaV1V0WWpabU55MDRNRE00?=
 =?utf-8?B?Wm1KbU1tTTJNakpjWVcxbExYUmxjM1JjTkRZM01EVmtPR0V0TTJFNE1DMHhN?=
 =?utf-8?B?V1ZsTFdJMlpqY3RPREF6T0daaVpqSmpOakl5WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?SXhNek13SWlCMFBTSXhNek16TmpRM05qa3hNVGN4T1RnNE1qY2lJR2c5SW1w?=
 =?utf-8?B?d1pWZFBaR3RRWjBWd1QwTk9lRUUyY1ZjcmNqZEZjRU5QTUQwaUlHbGtQU0lp?=
 =?utf-8?B?SUdKc1BTSXdJaUJpYnowaU1TSWdZMms5SW1OQlFVRkJSVkpJVlRGU1UxSlZS?=
 =?utf-8?B?azVEWjFWQlFVZEpWMEZCUkhKWFkyZEphbU0zV2tGWGQwNHdjMkZWUTI5VFNt?=
 =?utf-8?B?SkJNMU40Y0ZGTGFFbHJXa0ZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRklRVUZCUVVKMVJIZEJRVE5uT0VGQlNWRkhRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGRlFVRlJSVUpCUVVGQlNUZHhWSEJCUTBGQlVVRkJRVUZCUVVGQlFVRkJT?=
 =?utf-8?B?alJCUVVGQ2FFRkhVVUZhUVVKNVFVZFZRV04zUW5wQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlowRkJRVUZCUVc1blFVRkJSMDFCWkZGQ2VrRklVVUZpZDBKMFFVWTRRV05C?=
 =?utf-8?B?UW14QlNFbEJZM2RDZGtGSE5FRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRlJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVZsM1FqRkJTRTFCWkVGQ2Rr?=
 =?utf-8?B?RkhNRUZZZDBKM1FVZG5RV0ozUW5WQlIxVkJZbWRDTVVGSE1FRlpaMEpzUVVo?=
 =?utf-8?B?SlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVGQlFVSnFRVWhW?=
 =?utf-8?B?UVdOM1FqQkJSemhCWWxGQ1prRklUVUZqZDBKMVFVWTRRVnBCUW1oQlNFMUJZ?=
 =?utf-8?B?VUZDWmtGSVdVRk5RVUY1UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-refone: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5RVUZCUVVGQmJtZEJRVUZI?=
 =?utf-8?B?VFVGa1VVSjZRVWhSUVdKM1FuUkJSamhCWTNkQ2VrRkhORUZZZDBKeVFVZFZR?=
 =?utf-8?B?V1ZSUWpOQlJ6aEJZMmRDYTBGSVRVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJRVUZEUVVGQlFV?=
 =?utf-8?B?RkJRMlZCUVVGQldYZENNVUZJVFVGa1FVSjJRVWN3UVZoM1FucEJTRTFCWW1k?=
 =?utf-8?B?Q1prRkhORUZpZDBKclFVZFZRV0pCUW5CQlJ6QkJZVkZDTUVGSFZVRmpaMEpt?=
 =?utf-8?B?UVVoWlFVMUJRWGxCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVKQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlNVRkJRVUZCUVVvMFFVRkJRbXBCU0ZWQlkzZENNRUZIT0VGaVVVSm1R?=
 =?utf-8?B?VWhOUVdOM1FuVkJSamhCWTNkQ2QwRkhSVUZaZDBKc1FVWTRRV1JuUVhkQlJF?=
 =?utf-8?B?bEJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkZRVUZCUVVGQlFVRkJRV2RCUVVGQlFVRnVaMEZCUVVkUlFXSkJRbmRCUmpo?=
 =?utf-8?B?QlkzZENja0ZJYTBGalFVSnNRVVk0UVZsM1FtOUJSMFZCWkVGQ1prRkhNRUZh?=
 =?utf-8?B?VVVKNlFVaE5RVmxSUW01QlIxVkJXSGRDTWtGRVFVRk5aMEZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCVVVGQlFVRkJRVUZCUVVOQlFVRkJRVUZEWlVGQlFVRmFR?=
 =?utf-8?B?VUp6UVVoQlFWaDNRbnBCUjNkQldWRkNha0ZIYzBGWWQwSnFRVWRuUVZsUlFq?=
 =?utf-8?B?QkJSamhCWWxGQ2JFRklUVUZqZDBKb1FVZGpRVnBSUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-reftwo: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlNqUkJR?=
 =?utf-8?B?VUZDYTBGSGQwRmpRVUptUVVoUlFWcFJRbWhCUnpCQlkzZENaa0ZIT0VGaVow?=
 =?utf-8?B?SnNRVWRSUVdOblFuQkJTRmxCV2xGQ1prRkhXVUZoVVVKelFVZFZRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZCUVVGQlFVRkJRVUZCWjBG?=
 =?utf-8?B?QlFVRkJRVzVuUVVGQlIxVkJZbEZDYUVGSGEwRmlRVUptUVVkRlFWcEJRbXRC?=
 =?utf-8?B?U0VsQldsRkNla0ZJVFVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFXZEJRVUZCUVVGQlFVRkJRVUZCUVVGUlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlEwRkJRVUZCUVVObFFVRkJRV0pSUW1oQlNFbEJaR2RDYkVGSGQw?=
 =?utf-8?B?RllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZHT0VGaVowSm9RVWN3UVZw?=
 =?utf-8?B?UlFucEJSamhCV1hkQ2RrRkhORUZhWjBKd1FVZFJRVnBSUW5WQlNGRkJZVkZD?=
 =?utf-8?B?YUVGSGQwRllkMEpvUVVkM1FXSjNRblZCUjFWQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkNRVUZCUVVGQlFVRkJRVWxCUVVGQlFVRktORUZCUVVKMFFVZEZRV05u?=
 =?utf-8?B?UWpKQlIxVkJZa0ZDWmtGSVFVRmpaMEoyUVVkdlFWcFJRbXBCU0ZGQldIZENk?=
 =?utf-8?B?VUZIUlVGaVVVSnNRVWhOUVZoM1FubEJSMVZCWTNkQ01FRklTVUZoVVVKcVFV?=
 =?utf-8?B?aFJRVnBSUW10QlJqaEJXVkZDYzBGSE9FRmlaMEpzUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVGblFVRkJRVUZCYm1kQlFV?=
 =?utf-8?B?RkhNRUZaVVVKNVFVaFpRVnBSUW5OQlJqaEJZMEZDZVVGSE9FRmhaMEpzUVVk?=
 =?utf-8?B?TlFXUkJRbVpCUnpSQldWRkNkRUZIVlVGamQwSm1RVWhKUVZwUlFucEJTRkZC?=
 =?utf-8?B?WTJkQ2NFRkhUVUZrUVVKc1FVZFJRVmgzUW05QlIxVkJaVUZDYWtGSE9FRmFR?=
 =?utf-8?B?VUpzUVVoTlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJRVUZCUVVGQlFVRkRRVUZC?=
 =?utf-8?B?UVVGQlEyVkJRVUZCWWxGQ2FFRklTVUZrWjBKc1FVZDNRV0pCUW1aQlIwVkJZ?=
 =?utf-8?B?MmRDZEVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-refthree: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUpCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?U1VGQlFVRkJRVW8wUVVGQlFuUkJSMFZCWTJkQ01rRkhWVUZpUVVKelFVWTRR?=
 =?utf-8?B?VnAzUW5aQlJ6aEJXbmRDYzBGSFZVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGRlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFXZEJRVUZCUVVGdVowRkJRVWN3UVZsUlFubEJTRmxCV2xG?=
 =?utf-8?B?Q2MwRkhkMEZZZDBKM1FVaEpRV0ozUW5GQlIxVkJXWGRDTUVGR09FRlpkMEoy?=
 =?utf-8?B?UVVkUlFWcFJRbnBCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJVVUZCUVVGQlFVRkJRVU5CUVVGQlFVRkRaVUZCUVVGaVVVSm9R?=
 =?utf-8?B?VWhKUVdSblFteEJSM2RCWWtGQ1prRklRVUZqWjBKMlFVZHZRVnBSUW1wQlNG?=
 =?utf-8?B?RkJXSGRDYWtGSE9FRmFRVUpzUVVoTlFWaDNRbXRCUjJ0QldYZENNRUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUWtGQlFVRkJRVUZCUVVGSlFVRkJRVUZCU2pS?=
 =?utf-8?B?QlFVRkNkRUZIUlVGalowSXlRVWRWUVdKQlFuTkJSamhCWTBGQ2VVRkhPRUZo?=
 =?utf-8?B?WjBKc1FVZE5RV1JCUW1aQlJ6UkJXVkZDZEVGSFZVRmpkMEptUVVkTlFXSjNR?=
 =?utf-8?B?blZCUjFsQllWRkNhMEZIVlVGaVowSXdRVWRyUVZsUlFuTkJSamhCWWxGQ2FF?=
 =?utf-8?B?RklTVUZrWjBKc1FVZDNRV0pCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVVkJRVUZCUVVGQlFVRkJa?=
 =?utf-8?B?MEZCUVVGQlFXNW5RVUZCUnpCQldWRkNlVUZJV1VGYVVVSnpRVWQzUVZoM1Fu?=
 =?utf-8?B?ZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVWTRRV0puUW1oQlJ6QkJXbEZDZWtG?=
 =?utf-8?B?R09FRlpkMEoyUVVjMFFWcG5RbkJCUjFGQldsRkNkVUZJVVVGaFVVSm9RVWQz?=
 =?utf-8?B?UVZoM1FuUkJSMFZCWTJkQ01rRkhWVUZpUVVKelFVWTRRV0ozUW5sQlJqaEJX?=
 =?utf-8?B?VkZDZVVGSE1FRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-reffour: =?utf-8?B?UVVGQlFVRkJRVUZCUVdkQlFVRkJRVUZCUVVGQlFVRkJRVUZSUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUTBGQlFVRkJRVU5sUVVGQlFXSlJRbWhCU0VsQlpHZENiRUZIZDBGaVFV?=
 =?utf-8?B?Sm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZZZDBKMVFVZEZRV0pSUW14?=
 =?utf-8?B?QlNFMUJXSGRDYWtGSE9FRmlaMEp0UVVkclFWcEJRbXhCUnpSQlpFRkNjRUZI?=
 =?utf-8?B?UlVGaVFVSm1RVWN3UVZsUlFubEJTRmxCV2xGQ2MwRkhkMEZZZDBKMlFVaEpR?=
 =?utf-8?B?VmgzUW01QlJ6aEJZbmRDYmtGSGQwRmFVVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?Q1FVRkJRVUZCUVVGQlFVbEJRVUZCUVVGS05FRkJRVUowUVVkRlFXTm5RakpC?=
 =?utf-8?B?UjFWQllrRkNjMEZHT0VGalFVSjVRVWM0UVdGblFteEJSMDFCWkVGQ1prRkhO?=
 =?utf-8?B?RUZaVVVKMFFVZFZRV04zUW1aQlNFbEJXbEZDZWtGSVVVRmpaMEp3UVVkTlFX?=
 =?utf-8?B?UkJRbXhCUjFGQldIZENkRUZIUlVGalowSXlRVWRWUVdKQlFuTkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJSVUZCUVVGQlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSE1F?=
 =?utf-8?B?RlpVVUo1UVVoWlFWcFJRbk5CUjNkQldIZENkMEZJU1VGaWQwSnhRVWRWUVZs?=
 =?utf-8?B?M1FqQkJSamhCWW1kQ2FFRkhNRUZhVVVKNlFVWTRRV05uUW14QlNFMUJaRUZD?=
 =?utf-8?B?ZVVGSGEwRlpkMEl3UVVkVlFWcEJRbVpCUnpCQldWRkNlVUZJV1VGYVVVSnpR?=
 =?utf-8?B?VWQzUVZoM1FuWkJTRWxCV0hkQ2FFRklTVUZpVVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZC?=
 =?utf-8?B?UTJWQlFVRkJZbEZDYUVGSVNVRmtaMEpzUVVkM1FXSkJRbVpCU0ZGQldsRkNl?=
 =?utf-8?B?VUZITUVGaFVVSjFRVWhWUVdOM1FVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJTVUZCUVVGQlFVbzBRVUZCUW5SQlIwVkJZMmRDTWtGSFZVRmlRVUp6UVVZ?=
 =?utf-8?B?NFFXUjNRblpCU0VsQldrRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFVRkJRVUZCUVVGQlFVRkJRVUZG?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVdkQlFVRkJRVUZvUVZsQlFVRkJRVUZCUVdOQlFVRkJR?=
 =?utf-8?B?VkZCUVVGQlFVRkJRVU5zVGtaRGRUZDBkRk5UY1hWR2JuVkJTazlsTlVSSVFV?=
 =?utf-8?Q?FBQUFF?=
x-dg-reffive: =?utf-8?B?UVVGQlFVRkJRVUZCTVRCblptTmlNVXh6YTJWUVQzSTFTSFpRUlRGeGVXOUJR?=
 =?utf-8?B?VUZCUWtGQlFVRkpaMEZCUVVGQlFVRkJRbXBCUnpoQlltZENiVUZIYTBGYVFV?=
 =?utf-8?B?SnNRVWMwUVdSQlFuQkJSMFZCWWtGQlFVRkNiMGRCUVVGYVFVRkJRVWRCUVVG?=
 =?utf-8?B?QlFVRkJRVUZDYUVGSFVVRmFRVUo1UVVkVlFXTjNRbnBCUVVGQlNrRkJRVUZC?=
 =?utf-8?B?UVVGQlFVSnFRVWhWUVdOM1FqQkJSemhCWWxGQ1prRklRVUZhVVVKNVFVaE5R?=
 =?utf-8?B?V0ozUW5WQlFVRkJUR2RCUVVGQlFVRkJRVUpxUVVoVlFXTjNRakJCUnpoQlls?=
 =?utf-8?B?RkNaa0ZJUVVGaFFVSjJRVWMwUVZwUlFuVkJTRlZCWWxGQ2FVRkhWVUZqWjBG?=
 =?utf-8?B?QlFVUkJRVUZCUVVGQlFVRkJXWGRDTVVGSVRVRmtRVUoyUVVjd1FWaDNRbnBC?=
 =?utf-8?B?U0UxQlltZENaa0ZIVVVGWlVVSjZRVWRuUVZoM1FqSkJSRUZCVFdkQlFVRkVR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVmwzUWpGQlNFMUJaRUZDZGtGSE1FRllkMEo2UVVoTlFX?=
 =?utf-8?B?Sm5RbVpCUjNOQldsRkNOVUZJWTBGaWQwSjVRVWRSUVdOM1FVRkJSRFJCUVVG?=
 =?utf-8?B?QlFVRkJRVUZaZDBJeFFVaE5RV1JCUW5aQlJ6QkJXSGRDZWtGSVRVRmlaMEpt?=
 =?utf-8?B?UVVjMFFXSjNRbXRCUjFWQllrRkNjRUZITUVGaFVVSXdRVWRWUVdOblFtWkJT?=
 =?utf-8?B?RmxCVFVGQmVVRkJRVUZOWjBGQlFVRkJRVUZCUW1wQlNGVkJZM2RDTUVGSE9F?=
 =?utf-8?B?RmlVVUptUVVoTlFXTjNRblZCUmpoQlkzZENkMEZIUlVGWmQwSnNRVVk0UVdS?=
 =?utf-8?B?blFYZEJSRWxCUVVGQkswRkJRVUZCUVVGQlFVZFJRV0pCUW5kQlJqaEJZM2RD?=
 =?utf-8?B?Y2tGSWEwRmpRVUpzUVVZNFFWbDNRbTlCUjBWQlpFRkNaa0ZITUVGYVVVSjZR?=
 =?utf-8?B?VWhOUVZsUlFtNUJSMVZCV0hkQ01rRkVRVUZOWjBGQlFVUlpRVUZCUVVGQlFV?=
 =?utf-8?B?RkJXa0ZDYzBGSVFVRllkMEo2UVVkM1FWbFJRbXBCUjNOQldIZENha0ZIWjBG?=
 =?utf-8?B?WlVVSXdRVVk0UVdKUlFteEJTRTFCWTNkQ2FFRkhZMEZhVVVGQlFVUm5RVUZC?=
 =?utf-8?B?UVVGQlFVRkJXa0ZDYzBGSVFVRllkMEl3UVVkVlFWbFJRblJCU0UxQldIZENk?=
 =?utf-8?B?a0ZITkVGYVVVSnJRVWhKUVdGUlFqSkJSMVZCV0hkQ2JVRkhhMEZpUVVKc1FV?=
 =?utf-8?B?RkJRVXBCUVVGQlFVbEJRVUZDYkVGSE1FRlpVVUp3UVVkM1FWaDNRbWhCUjFG?=
 =?utf-8?B?QldrRkNlVUZIVlVGamQwSjZRVUZCUVZkQlFVRkJRVUZCUVVGQ2RFRkhSVUZq?=
 =?utf-8?B?WjBJeVFVZFZRV0pCUW1aQlNFRkJZMmRDZGtGSGIwRmFVVUpxUVVoUlFWaDNR?=
 =?utf-8?B?blZCUjBWQllsRkNiRUZJVFVGWWQwSnFRVWM0UVdKblFtMUJSMnRCV2tGQ2JF?=
 =?utf-8?B?RkhORUZrUVVKd1FVZEZRV0pCUW1aQlIwVkJZa0ZDZGtGSE5FRmFVVUZCUVVa?=
 =?utf-8?B?UlFVRkJRVUZCUVVGQllsRkNhRUZJU1VGa1owSnNRVWQzUVZoM1FuZEJTRWxC?=
 =?utf-8?B?WW5kQ2NVRkhWVUZaZDBJd1FVWTRRV0puUW1oQlJ6QkJXbEZDZWtGR09FRmpa?=
 =?utf-8?B?MEpzUVVoTlFXUkJRbmxCUjJ0QldYZENNRUZIVlVGYVFVSm1RVWRGUVdKQlFu?=
 =?utf-8?B?WkJSelJCV2xGQlFVRkdiMEZCUVVGQlFVRkJRV0pSUW1oQlNFbEJaR2RDYkVG?=
 =?utf-8?B?SGQwRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZHT0VGaVowSm9RVWN3?=
 =?utf-8?B?UVZwUlFucEJSamhCWTJkQ2JFRklUVUZrUVVKNVFVZHJRVmwzUWpCQlIxVkJX?=
 =?utf-8?B?a0ZDWmtGSFowRmFVVUkwUVVkTlFXSjNRbXRCUjFWQlkzZEJRVUZEUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-tag-bcast: {BB38C8B4-BBDA-40C5-8168-0013E523D1A2}
x-dg-refsix: =?utf-8?B?UVdKUlFtaEJTRWxCWkdkQ2JFRkhkMEZpUVVKbVFVZEZRV05uUW5SQlFVRkJT?=
 =?utf-8?B?bWRCUVVGQlFVRkJRVUowUVVkRlFXTm5RakpCUjFWQllrRkNjMEZHT0VGYWQw?=
 =?utf-8?B?SjJRVWM0UVZwM1FuTkJSMVZCUVVGQk1FRkJRVUZCUVVGQlFVY3dRVmxSUW5s?=
 =?utf-8?B?QlNGbEJXbEZDYzBGSGQwRllkMEozUVVoSlFXSjNRbkZCUjFWQldYZENNRUZH?=
 =?utf-8?B?T0VGWmQwSjJRVWRSUVZwUlFucEJRVUZCVUdkQlFVRkJRVUZCUVVKMFFVZEZR?=
 =?utf-8?B?V05uUWpKQlIxVkJZa0ZDYzBGR09FRmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpF?=
 =?utf-8?B?RkNaa0ZIVFVGaWQwSnJRVWRWUVdOM1FtWkJSMUZCWVZGQ2FrRklVVUZCUVVK?=
 =?utf-8?B?bFFVRkJRVUZCUVVGQlJ6QkJXVkZDZVVGSVdVRmFVVUp6UVVkM1FWaDNRbmRC?=
 =?utf-8?B?U0VsQlluZENjVUZIVlVGWmQwSXdRVVk0UVdKblFtaEJSekJCV2xGQ2VrRkdP?=
 =?utf-8?B?RUZaZDBKMlFVYzBRVnBuUW5CQlIxRkJXbEZDZFVGSVVVRmhVVUpvUVVkM1FW?=
 =?utf-8?B?aDNRblJCUjBWQlkyZENNa0ZIVlVGaVFVSnpRVUZCUVdKQlFVRkJRVWxCUVVG?=
 =?utf-8?B?Q2RFRkhSVUZqWjBJeVFVZFZRV0pCUW5OQlJqaEJZMEZDZVVGSE9FRmhaMEpz?=
 =?utf-8?B?UVVkTlFXUkJRbVpCUnpSQldWRkNkRUZIVlVGamQwSm1RVWROUVdKM1FuVkJS?=
 =?utf-8?B?MWxCWVZGQ2EwRkhWVUZpWjBJd1FVZHJRVmxSUW5OQlJqaEJZbEZDYUVGSVNV?=
 =?utf-8?B?RmtaMEpzUVVkM1FXSkJRbVpCUnpoQlkyZENaa0ZIUlVGalowSjBRVUZCUVdO?=
 =?utf-8?B?blFVRkJRVUZCUVVGQ2RFRkhSVUZqWjBJeVFVZFZRV0pCUW5OQlJqaEJZMEZD?=
 =?utf-8?B?ZVVGSE9FRmhaMEpzUVVkTlFXUkJRbVpCUnpSQldWRkNkRUZIVlVGamQwSm1R?=
 =?utf-8?B?VWROUVdKM1FuVkJSMWxCWVZGQ2EwRkhWVUZpWjBJd1FVZHJRVmxSUW5OQlJq?=
 =?utf-8?B?aEJZbEZDYUVGSVNVRmtaMEpzUVVkM1FXSkJRbVpCUnpoQlkyZENaa0ZIWTBG?=
 =?utf-8?B?aWQwSjJRVWRqUVdKQlFteEJRVUZCVjJkQlFVRkJRVUZCUVVKMFFVZEZRV05u?=
 =?utf-8?B?UWpKQlIxVkJZa0ZDYzBGR09FRmpRVUo1UVVjNFFXRm5RbXhCUjAxQlpFRkNa?=
 =?utf-8?B?a0ZITkVGWlVVSjBRVWRWUVdOM1FtWkJTRWxCV2xGQ2VrRklVVUZqWjBKd1FV?=
 =?utf-8?B?ZE5RV1JCUW14QlIxRkJXSGRDZEVGSFJVRmpaMEl5UVVkVlFXSkJRbk5CUVVG?=
 =?utf-8?B?QllVRkJRVUZCUVVGQlFVSjBRVWRGUVdOblFqSkJSMVZCWWtGQ2MwRkdPRUZq?=
 =?utf-8?B?UVVKNVFVYzRRV0ZuUW14QlIwMUJaRUZDWmtGSE5FRlpVVUowUVVkVlFXTjNR?=
 =?utf-8?B?bVpCU0VsQldsRkNla0ZJVVVGalowSndRVWROUVdSQlFteEJSMUZCV0hkQ2RF?=
 =?utf-8?B?RkhSVUZqWjBJeVFVZFZRV0pCUW5OQlJqaEJZbmRDZVVGR09FRlpVVUo1UVVj?=
 =?utf-8?B?d1FVRkJRWEZCUVVGQlFVRkJRVUZITUVGWlVVSjVRVWhaUVZwUlFuTkJSM2RC?=
 =?utf-8?B?V0hkQ01FRkhWVUZqWjBKMFFVZHJRV0puUWpGQlNFMUJRVUZCYVVGQlFVRkJV?=
 =?utf-8?B?VUZCUVVjd1FWbFJRbmxCU0ZsQldsRkNjMEZIZDBGWWQwSXpRVWM0UVdOblFt?=
 =?utf-8?B?dEJRVUZCSWk4K1BDOXRaWFJoUGc9PQ==?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|BN9PR18MB4218:EE_
x-ms-office365-filtering-correlation-id: 1403d4c5-3f1d-4d7b-3036-08db9ca42d32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ervs2b5XDRxVhM7rIo7ZxE2daA9hNUTaNJQjc7UkVWiF/WzwK+Hw8NiyGsmq2AcxA5VkdR2m2qroXF144gzIiAdBmZWoVKg1uJo3sJg8Y78AUa1oYdEZkfCRszMt/RCupYzBDfl9QEkOrzJoHOxbq4FXe8jNUmhzU15ofcyf13uUm7qdtKIGigQEoYOfhOs3zSLhbnUL0i3d5IPfQ5AFBRf0jE498Z9D/kS3o4s84k2jwJWbbADgwgNWXJNVqsxWROIPSUPTmT1uyR2z5fAUI3H1MV3fwQnp+NRwB2TMgqV4/7AAYRt3olew/QDtypB6H1tg21LqiVnGBIumvbJiNWLOgE3CT9KBnYDB2RqkZAlqG2n+IS9l0kuDC3bGD41cHBI18gCtNYc38rakl4SX1cmlDP8cJBc1rVJrQL6Z4SGGpo9nlqxWFK/43TB2MG36JaWxEYrMNPjJCW0lgO3pSrlCOYgcji3niSDDU3JUKt4C/Rj64jeVYL7vofrc4DQhqaDa1jB5rTNzatjbyC43hSWPZCUsXuNCyPvHoYzHQSvOqCe+xkCbP8loFt/BYmUx3RxtqJ9yUPCeyLf6r8r9QR72xDRQMF2LwuXOWjeHe6JDDV8DRbs6tJ4adL+06j0jDPHZpe+RpgZucHwxZDaQUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(376002)(346002)(39860400002)(451199021)(1800799006)(186006)(38100700002)(55016003)(54906003)(110136005)(19627235002)(7696005)(71200400001)(478600001)(122000001)(7336002)(7416002)(7366002)(7406005)(52536014)(38070700005)(5660300002)(2906002)(33656002)(86362001)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(41300700001)(8936002)(8676002)(316002)(55236004)(6506007)(26005)(83380400001)(9686003)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eElUNFE3M2lTanJEcExZWStKZitJVTFZMDQ5NGN2aXBHSUk3ZExZVmZ6RDNH?=
 =?utf-8?B?NGxjS0F6YjhmNm5HNGszWlcydlZ5RUtGWTlVbDFzdG1DS1NLaEVyWmFvN1Fk?=
 =?utf-8?B?QmVxa3pKWGtodEZZZHAxMktFeVk0djBsNlBNSEM5M0QrdnNJNUdpQzVEWjhK?=
 =?utf-8?B?UVgwaDhKWk5CRDdMT0ZsV3VoNklsVHp4RWRpRGFuZlY1ajA3MGNXcUM1T044?=
 =?utf-8?B?eis5WkU1dHJDT3FEb04wQ2J6RVNKY1RTTGlRUW9TamFvWFlQMExDditVcEhL?=
 =?utf-8?B?K0R4NDlFWVBEMHhDY3VKeG8zOXJzclRVK1E3KzRsbDBydStvUmpjdlNDM0t3?=
 =?utf-8?B?N2RndTlKTTIrdXNJdXJFNUZZWE5LNEx5amVpbTJTT01iMFJSYzY1ODdQdkJz?=
 =?utf-8?B?YlZZS2YrUXpNdGtuNWdKUDNHaDQ4QWsza3lLMW1ReXJsbm5ZOU55YWpqVU8y?=
 =?utf-8?B?QzdKVm5qU2lndlA3TXh0bUkvNHJXSWttWGZTMEFPSzdvdXZlZjBXUVZvSTZs?=
 =?utf-8?B?a1RXcjRaVlg4MzhjNmNUbTVEV3BnTnVScjhOUFQ4OHZicVd4c2Jzd3YwWHF0?=
 =?utf-8?B?Slp0dHZmczB1VXYvS0tSSlNTd1Y2anZwbUNkMWNLV0dsenNxSGNaVURsY2oz?=
 =?utf-8?B?Z2xmMmExTC9iNUxpSm8yM3NQa2Vua0VTUnkzeGZBVm8wd0xVZmhPNGZ5c3Zv?=
 =?utf-8?B?MjhQKzQwMzRHUDJUMlVaUGRSZEU4NU0yUXJZek8weXNMeTQ0bHR3UG9OSUxo?=
 =?utf-8?B?Y1A4Q0VPUjRLektUT01FazZzejBmVjRLbzVkdzhVSjZQVklJbjBNSURHbFRn?=
 =?utf-8?B?dzBXWVhiaTg5SHVnSWI3WUs4RHRsY1I3dG5xY2Q3ajFFbFRNK3NFdUFiV1hZ?=
 =?utf-8?B?UVRLR3pHVTRCUmJ6Zmg0R0t1d2J6d3N1ZGFLd29jWDBnODE5N2pIc0hpUmxU?=
 =?utf-8?B?d2kyNzRzdTg4d25wblZjT2hKeW05b3N1cmJaejZIaW9BUHBYeDlhV0VZemRZ?=
 =?utf-8?B?RFBiRFJUdExmOG50Tys1eXRNOW4xbjQ2Z3hXT2VocVdCU3BzMWQ5WmVQZEtv?=
 =?utf-8?B?QVhIM3U2TUNWNllzZURVa3RtS2gwV3JUVFVHaUh3RzhrYVZpTzlCRHA4a21U?=
 =?utf-8?B?YUUxbGRyRUFPZ3Q2SXZkemYwUUNkcElZOXc3SytuTFR1MkdxQ09ISDY4NTBl?=
 =?utf-8?B?TmVyTXVEK0QwRTJoY1pXQzNYNUNFd0VmdlRpWW9vNko3cTBnTXhiaU9NOUNs?=
 =?utf-8?B?eTVLZHZJRzQ5VldtaWJZcFR6RFQxV1MwVzlvdFVtNmllWnYyQWZUREdFRG1n?=
 =?utf-8?B?UldOM2pNS0hMR0NlNnQ4aWVEMEU5RDlNVktMQlE1QUV2VnFGMG1NNEZXRHU5?=
 =?utf-8?B?dVR2NFNlZFJCdTcxd05nNCs0UTd3aURST1B2LzgxdDNYZEJEZG5NSktYUW94?=
 =?utf-8?B?NWtrMWhldEM0WEcxc3E4Y0hLR05CcXlGSlA1b3hZM0dmelArckRyTTNVeVlV?=
 =?utf-8?B?VFBtSlZHSE5aYjA5TmhvdmFLOXBBZjdQOWs3RmJici8zd1V5MzlBaGZ5K2pC?=
 =?utf-8?B?TXk5YXdrUDNlNS95MGcxTWlMUmhXeEVXenJjQmxGZHkzSzRBSGxsUVF0c08v?=
 =?utf-8?B?Y1dFS0dsbzFySW1SUDNBNDF2MFFBbThOZ08xWFN6UVlzd1FQYUp6aFNNL051?=
 =?utf-8?B?SVNPLzhRZmIrdjUrT1JNcjMyWFpTWmVtT05ERldaRi8yRGlUZHRFZVp5T0ZV?=
 =?utf-8?B?YUR3Yktham84cjdFbFY4REk5R3FvbE41NEdHbkoyaldBTUhDckZTVWg2MjJo?=
 =?utf-8?B?TUlHUTN5TGhrWTRkcmR3Q0V3RFNmN0ZVZUZiV0Jrd1dXOXdyMDlRdFpaeW9k?=
 =?utf-8?B?dWJYMFhOV1UxZzNLNUtGVTc1bERraEJVdmpUcldSQ25vaStzL2FIdzVUVXJ2?=
 =?utf-8?B?b3Fzd2o2cEt0dElkT2dDQkdmRUUxdFVrb1M0VjJKNGdLeVV3YWp3ZGZQRHQ0?=
 =?utf-8?B?Q0lhM0JYNi9peUc4QUZNTTlQMzVXNEpQSUdBVW1uT0V3cVErVnc3cjQ2QnlE?=
 =?utf-8?B?a3J6cEJvbXhOdFVFc3pHNjNuN2RoMzB4Y0Vsc1pPTWlSV096U0RPdjIxeEoz?=
 =?utf-8?Q?tuKvMuDdvGt9m09ftYBhIGbKV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1403d4c5-3f1d-4d7b-3036-08db9ca42d32
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:55:14.9683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tEQ2Lj2R5COsWOyoJVNnUSmF9cho/4qEBN2oS9h/PIyBPLfwWDhz0C1//gKEciGE2Rla/akpatL/YvZhr5ZNwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR18MB4218
X-Proofpoint-ORIG-GUID: VKSPZR_T51MpOOi_5HyduhDxSjK4c4Ug
X-Proofpoint-GUID: VKSPZR_T51MpOOi_5HyduhDxSjK4c4Ug
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_03,2023-08-10_01,2023-05-22_02
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

PiBGcm9tOiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxoYXdrQGtlcm5lbC5vcmc+DQo+IFN1Ympl
Y3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIHYxIG5ldF0gcGFnZV9wb29sOiBDYXAgcXVldWUgc2l6
ZSB0byAzMmsuDQoNCg0KPiBJIGFncmVlIHdpdGggSm9oYW5uZXMsIHRoaXMgY29tbWl0IG1lc3Nh
Z2UgaXMgdG9vIHRoaW4uDQpBQ0suDQoNCiANCj4gSXQgbWFrZXMgc2Vuc2UgdG8gZ2l2ZSBhIHN1
bW1hcnkgb2YgdGhlIGRpc2N1c3Npb24sIGJlY2F1c2UgaXQgc2hvdyB1cw0KPiAocGFnZV9wb29s
IG1haW50YWluZXJzKSB3aGF0IHlvdSBjb25jbHVkZWQgZm9yIHRoZSBkaXNjdXNzaW9uLg0KR290
IGl0LiBUaGFua3MuIA0KDQo+IEZ1cnRoZXIgbW9yZSwgeW91IGFsc28gc2VuZCBhbm90aGVyIHBh
dGNoOg0KPiAgIC0gIltQQVRDSCBuZXQtbmV4dF0gcGFnZV9wb29sOiBTZXQgcGFnZSBwb29sIHNp
emUiDQpPa2F5LiANCg0KPiAgIC0NCj4gaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29t
L3YyL3VybD91PWh0dHBzLQ0KPiAzQV9fbG9yZS5rZXJuZWwub3JnX2FsbF8yMDIzMDgwOTAyMTky
MC45MTMzMjQtMkQxLTJEcmthbm5vdGgtDQo+IDQwbWFydmVsbC5jb21fJmQ9RHdJQ2FRJmM9bktq
V2VjMmI2UjBtT3lQYXo3eHRmUSZyPWFla2NzeUJDSDAwDQo+IF9MZXdyRURjUUJ6c1J3OEtDcFVS
MHZaYl9hdVRIazRNJm09dXZWX3Z0X2NOeVFJdFREOTBqRjFMZEtvdlANCj4gN2o3Rll0bnI3STM4
X19uWVk2d0h0RkhTb3pZb1JTU3ZDSTE0bmgmcz12R2d0MmNjR2RpUlRFaGozTW9HVngtDQo+IEVY
SG1CMDN2NkkzVUlJWTFmRWIyNCZlPQ0KPiANCj4gVGhhdCBwYXRjaCBzb2x2ZXMgdGhlIGlzc3Vl
IGZvciB5b3VyIGRyaXZlciBtYXJ2ZWxsL29jdGVvbnR4MiBhbmQgSSBsaWtlIHRoYW4NCj4gY2hh
bmdlLg0KT2theS4gDQoNCj4gV2h5IGRpZCB5b3UgY29uY2x1ZGUgdGhhdCBQUCBjb3JlIHNob3Vs
ZCBhbHNvIGNoYW5nZT8NCkkgY291bGQgbm90ICBhbnN3ZXIgSmFjdWIncyBxdWVzdGlvbiBhdCBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRkZXYvMjAyMzA4MTAwMjQ0MjIuMTc4MTMxMi0xLXJr
YW5ub3RoQG1hcnZlbGwuY29tL1QvIA0KDQo+IChwLnMuIENjL1RvIGxpc3QgaGF2ZSBnb3R0ZW4g
ZXhjZXNzaXZlIHdpdGggODkgcmVjaXBpZW50cykNCkkgYWRkZWQgbWFpbnRhaW50ZXJzIG9mIGFs
bCBmaWxlcyB3aGljaCB1c2VkIHBhZ2VfcG9vbF9pbml0KCkuIA0KDQo=
