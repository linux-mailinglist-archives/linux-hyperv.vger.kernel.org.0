Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7E77B34B
	for <lists+linux-hyperv@lfdr.de>; Mon, 14 Aug 2023 10:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbjHNIHA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 14 Aug 2023 04:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbjHNIGm (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 14 Aug 2023 04:06:42 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9229F;
        Mon, 14 Aug 2023 01:06:41 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37E7jqPn003829;
        Mon, 14 Aug 2023 01:05:52 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3se9kj59d8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Aug 2023 01:05:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FA27O2NGHAlo++iIO7u9u0PFGAs2nHTxnXyElxAK1k76QgNlHTnzlZnh2izPe3mYwCUstWPQY6Jt/nYouGiGpC3xx+t92/rww4K75+0cEuwLTCCJIvtAHuHXvnTjfjn3OxS+BwZqZaNf4RV+/uew2JBFdJqd24z45KBjuPTiU4+CVlaKI9XNyMW+5ink2Zwungabn43aL4+xjU4yyBTa7RcBrPXfH4hEywZOP/3R+DgzAJg6dpiR5TUYixB5BVBgGJTi8LyR18z1njLdo0FArSm6RUjFdNKSD6xt5c9YjuknEhcuoqIWVXAeXGTL/VCQR0ZlcPh0D4ImdaNZZ70j4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLST6jG+mopecdBolQXESTSj7sSZ22hpvp5nmgIt1vI=;
 b=S9wLTs/lHp6u0/b6E/VamHaXwp6jOIn2wJL4g1fyQkXwUaGb6TBY6EOYMP7tKbDBt4vzk4sYdhJZeyIdbGPJtezkjor/T1Xf/+XCucgJq3ZXw/lP33E6BSbUTYy93TNUOScFuCWnE5GW59pBBPOOiegOgP3dZwzLqyeEqNO/CSaiikb1/9C+h0fteBq6FqIdRC7jgrWogfYB3J6KcetytPH6uhTg7mieIBYPo1A709bRqvJwb2JPsBnqMuLKxKNdyx7JlkaEAiMFUMw8WnRSEtOTwZ95uMxHDRdHuWLiIbvEJrSdmuO4zPbNev5D0MPnqdbVNZDe0PAcJIi5BxO1ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLST6jG+mopecdBolQXESTSj7sSZ22hpvp5nmgIt1vI=;
 b=X/Tum8TP1ptwUGZWUD8+RDOFyv1Qg3mtaik+qjLlKlrWu62MtA/NmWwX6pr4EpBU8uSXc8hS/3SmY0n7wjwWt84+aWurKuVfDyW/LHJQKkD1cVNcbz2SRr2cAbJj80DWSopbTyBLs5Qs81sMOo3D8rbDDFIAqwyxZoVlFWptqa8=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by DM6PR18MB3507.namprd18.prod.outlook.com
 (2603:10b6:5:2a4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 08:05:47 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::9ee9:35fc:cabe:11a1]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::9ee9:35fc:cabe:11a1%6]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 08:05:47 +0000
From:   Ratheesh Kannoth <rkannoth@marvell.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hawk@kernel.org" <hawk@kernel.org>,
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
        "yisen.zhuang@huawei.com" <yisen.zhuang@huawei.com>,
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
Thread-Index: AQHZznU+ZcDNaqRkgEScX+JwHjZ6da/pbFAAgAAB4aA=
Date:   Mon, 14 Aug 2023 08:05:46 +0000
Message-ID: <MWHPR1801MB1918230E007D7B2C5A768B37D317A@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20230814060411.2401817-1-rkannoth@marvell.com>
 <8c6d19da5c4c38062b7a4e500de1d5dc1280fbc8.camel@sipsolutions.net>
In-Reply-To: <8c6d19da5c4c38062b7a4e500de1d5dc1280fbc8.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-rorf: true
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jY210aGJtNXZkR2hjWVhCd1pHRjBZVnh5YjJGdGFXNW5YREE1WkRnME9X?=
 =?utf-8?B?STJMVE15WkRNdE5HRTBNQzA0TldWbExUWmlPRFJpWVRJNVpUTTFZbHh0YzJk?=
 =?utf-8?B?elhHMXpaeTAxWkRkbFl6ZGpPUzB6WVRjNUxURXhaV1V0WWpabU55MDRNRE00?=
 =?utf-8?B?Wm1KbU1tTTJNakpjWVcxbExYUmxjM1JjTldRM1pXTTNZMkl0TTJFM09TMHhN?=
 =?utf-8?B?V1ZsTFdJMlpqY3RPREF6T0daaVpqSmpOakl5WW05a2VTNTBlSFFpSUhONlBT?=
 =?utf-8?B?STROVElpSUhROUlqRXpNek0yTkRjek9UUXpPVEUzT0RBM09TSWdhRDBpVkRK?=
 =?utf-8?B?cllYRlNUWE15U0M5Q2EzWnhWSGx6ZUVGbWFrdHJWbnBSUFNJZ2FXUTlJaUln?=
 =?utf-8?B?WW13OUlqQWlJR0p2UFNJeElpQmphVDBpWTBGQlFVRkZVa2hWTVZKVFVsVkdU?=
 =?utf-8?B?a05uVlVGQlRqUlFRVUZDWm5Oa1ZXWm9jemRhUVZoeU1HUTNiRkkyZDFCb1pY?=
 =?utf-8?B?WlNNM1ZXU0hKQkswVmFRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVaEJRVUZCUW5WRWQwRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVWQlFWRkZRa0ZCUVVGSk4zRlVjRUZEUVVGUlFVRkJRVUZCUVVGQlFVRktO?=
 =?utf-8?B?RUZCUVVKb1FVZFJRVnBCUW5sQlIxVkJZM2RDZWtGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUlVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?blFVRkJRVUZCYm1kQlFVRkhUVUZrVVVKNlFVaFJRV0ozUW5SQlJqaEJZMEZD?=
 =?utf-8?B?YkVGSVNVRmpkMEoyUVVjMFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFWRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkRRVUZCUVVGQlEyVkJRVUZCV1hkQ01VRklUVUZrUVVKMlFV?=
 =?utf-8?B?Y3dRVmgzUW5kQlIyZEJZbmRDZFVGSFZVRmlaMEl4UVVjd1FWbG5RbXhCU0Vs?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUpCUVVGQlFVRkJRVUZCU1VGQlFVRkJRVW8wUVVGQlFtcEJTRlZC?=
 =?utf-8?B?WTNkQ01FRkhPRUZpVVVKbVFVaE5RV04zUW5WQlJqaEJXa0ZDYUVGSVRVRmhR?=
 =?utf-8?B?VUptUVVoWlFVMUJRWGxCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-refone: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGRlFVRkJRVUZCUVVGQlFXZEJRVUZCUVVGdVowRkJRVWRO?=
 =?utf-8?B?UVdSUlFucEJTRkZCWW5kQ2RFRkdPRUZqZDBKNlFVYzBRVmgzUW5KQlIxVkJa?=
 =?utf-8?B?VkZDTTBGSE9FRmpaMEpyUVVoTlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJVVUZCUVVGQlFVRkJRVU5CUVVGQlFV?=
 =?utf-8?B?RkRaVUZCUVVGWmQwSXhRVWhOUVdSQlFuWkJSekJCV0hkQ2VrRklUVUZpWjBK?=
 =?utf-8?B?bVFVYzBRV0ozUW10QlIxVkJZa0ZDY0VGSE1FRmhVVUl3UVVkVlFXTm5RbVpC?=
 =?utf-8?B?U0ZsQlRVRkJlVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUWtGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGSlFVRkJRVUZCU2pSQlFVRkNha0ZJVlVGamQwSXdRVWM0UVdKUlFtWkJT?=
 =?utf-8?B?RTFCWTNkQ2RVRkdPRUZqZDBKM1FVZEZRVmwzUW14QlJqaEJaR2RCZDBGRVNV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?VkJRVUZCUVVGQlFVRkJaMEZCUVVGQlFXNW5RVUZCUjFGQllrRkNkMEZHT0VG?=
 =?utf-8?B?amQwSnlRVWhyUVdOQlFteEJSamhCV1hkQ2IwRkhSVUZrUVVKbVFVY3dRVnBS?=
 =?utf-8?B?UW5wQlNFMUJXVkZDYmtGSFZVRllkMEl5UVVSQlFVMW5RVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZSUVVGQlFVRkJRVUZCUTBGQlFVRkJRVU5sUVVGQlFWcEJR?=
 =?utf-8?B?bk5CU0VGQldIZENla0ZIZDBGWlVVSnFRVWR6UVZoM1FtcEJSMmRCV1ZGQ01F?=
 =?utf-8?B?RkdPRUZpVVVKc1FVaE5RV04zUW1oQlIyTkJXbEZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-reftwo: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQ1FVRkJRVUZCUVVGQlFVbEJRVUZCUVVGS05FRkJR?=
 =?utf-8?B?VUpyUVVkM1FXTkJRbVpCU0ZGQldsRkNhRUZITUVGamQwSm1RVWM0UVdKblFt?=
 =?utf-8?B?eEJSMUZCWTJkQ2NFRklXVUZhVVVKbVFVZFpRV0ZSUW5OQlIxVkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVGQlFVRkJRVUZuUVVG?=
 =?utf-8?B?QlFVRkJibWRCUVVGSFZVRmlVVUpvUVVkclFXSkJRbVpCUjBWQldrRkNhMEZJ?=
 =?utf-8?B?U1VGYVVVSjZRVWhOUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlVVRkJRVUZCUVVGQlFVRkJRVUZCUVZGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJZbEZDYUVGSVNVRmtaMEpzUVVkM1FW?=
 =?utf-8?B?aDNRbmRCU0VsQlluZENjVUZIVlVGWmQwSXdRVVk0UVdKblFtaEJSekJCV2xG?=
 =?utf-8?B?Q2VrRkdPRUZaZDBKMlFVYzBRVnBuUW5CQlIxRkJXbEZDZFVGSVVVRmhVVUpv?=
 =?utf-8?B?UVVkM1FWaDNRbWhCUjNkQlluZENkVUZIVlVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVbzBRVUZCUW5SQlIwVkJZMmRD?=
 =?utf-8?B?TWtGSFZVRmlRVUptUVVoQlFXTm5RblpCUjI5QldsRkNha0ZJVVVGWWQwSjFR?=
 =?utf-8?B?VWRGUVdKUlFteEJTRTFCV0hkQ2VVRkhWVUZqZDBJd1FVaEpRV0ZSUW1wQlNG?=
 =?utf-8?B?RkJXbEZDYTBGR09FRlpVVUp6UVVjNFFXSm5RbXhCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdkQlFVRkJRVUZ1WjBGQlFV?=
 =?utf-8?B?Y3dRVmxSUW5sQlNGbEJXbEZDYzBGR09FRmpRVUo1UVVjNFFXRm5RbXhCUjAx?=
 =?utf-8?B?QlpFRkNaa0ZITkVGWlVVSjBRVWRWUVdOM1FtWkJTRWxCV2xGQ2VrRklVVUZq?=
 =?utf-8?B?WjBKd1FVZE5RV1JCUW14QlIxRkJXSGRDYjBGSFZVRmxRVUpxUVVjNFFWcEJR?=
 =?utf-8?B?bXhCU0UxQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJRVUZCUVVGQlFVTkJRVUZC?=
 =?utf-8?B?UVVGRFpVRkJRVUZpVVVKb1FVaEpRV1JuUW14QlIzZEJZa0ZDWmtGSFJVRmpa?=
 =?utf-8?B?MEowUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-refthree: =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRa0ZCUVVGQlFVRkJRVUZK?=
 =?utf-8?B?UVVGQlFVRkJTalJCUVVGQ2RFRkhSVUZqWjBJeVFVZFZRV0pCUW5OQlJqaEJX?=
 =?utf-8?B?bmRDZGtGSE9FRmFkMEp6UVVkVlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVWQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlowRkJRVUZCUVc1blFVRkJSekJCV1ZGQ2VVRklXVUZhVVVK?=
 =?utf-8?B?elFVZDNRVmgzUW5kQlNFbEJZbmRDY1VGSFZVRlpkMEl3UVVZNFFWbDNRblpC?=
 =?utf-8?B?UjFGQldsRkNla0ZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRlJRVUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxRVUZCUVdKUlFtaEJT?=
 =?utf-8?B?RWxCWkdkQ2JFRkhkMEZpUVVKbVFVaEJRV05uUW5aQlIyOUJXbEZDYWtGSVVV?=
 =?utf-8?B?RllkMEpxUVVjNFFWcEJRbXhCU0UxQldIZENhMEZIYTBGWmQwSXdRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZDUVVGQlFVRkJRVUZCUVVsQlFVRkJRVUZLTkVG?=
 =?utf-8?B?QlFVSjBRVWRGUVdOblFqSkJSMVZCWWtGQ2MwRkdPRUZqUVVKNVFVYzRRV0Zu?=
 =?utf-8?B?UW14QlIwMUJaRUZDWmtGSE5FRlpVVUowUVVkVlFXTjNRbVpCUjAxQlluZENk?=
 =?utf-8?B?VUZIV1VGaFVVSnJRVWRWUVdKblFqQkJSMnRCV1ZGQ2MwRkdPRUZpVVVKb1FV?=
 =?utf-8?B?aEpRV1JuUW14QlIzZEJZa0ZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlJVRkJRVUZCUVVGQlFVRm5R?=
 =?utf-8?B?VUZCUVVGQmJtZEJRVUZITUVGWlVVSjVRVWhaUVZwUlFuTkJSM2RCV0hkQ2Qw?=
 =?utf-8?B?RklTVUZpZDBKeFFVZFZRVmwzUWpCQlJqaEJZbWRDYUVGSE1FRmFVVUo2UVVZ?=
 =?utf-8?B?NFFWbDNRblpCUnpSQldtZENjRUZIVVVGYVVVSjFRVWhSUVdGUlFtaEJSM2RC?=
 =?utf-8?B?V0hkQ2RFRkhSVUZqWjBJeVFVZFZRV0pCUW5OQlJqaEJZbmRDZVVGR09FRlpV?=
 =?utf-8?B?VUo1UVVjd1FVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-reffour: =?utf-8?B?UVVGQlFVRkJRVUZCWjBGQlFVRkJRVUZCUVVGQlFVRkJRVkZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZEUVVGQlFVRkJRMlZCUVVGQllsRkNhRUZJU1VGa1owSnNRVWQzUVdKQlFt?=
 =?utf-8?B?WkJTRUZCWTJkQ2RrRkhiMEZhVVVKcVFVaFJRVmgzUW5WQlIwVkJZbEZDYkVG?=
 =?utf-8?B?SVRVRllkMEpxUVVjNFFXSm5RbTFCUjJ0QldrRkNiRUZITkVGa1FVSndRVWRG?=
 =?utf-8?B?UVdKQlFtWkJSekJCV1ZGQ2VVRklXVUZhVVVKelFVZDNRVmgzUW5aQlNFbEJX?=
 =?utf-8?B?SGRDYmtGSE9FRmlkMEp1UVVkM1FWcFJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVK?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlNVRkJRVUZCUVVvMFFVRkJRblJCUjBWQlkyZENNa0ZI?=
 =?utf-8?B?VlVGaVFVSnpRVVk0UVdOQlFubEJSemhCWVdkQ2JFRkhUVUZrUVVKbVFVYzBR?=
 =?utf-8?B?VmxSUW5SQlIxVkJZM2RDWmtGSVNVRmFVVUo2UVVoUlFXTm5RbkJCUjAxQlpF?=
 =?utf-8?B?RkNiRUZIVVVGWWQwSjBRVWRGUVdOblFqSkJSMVZCWWtGQ2MwRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVGQlFVRnVaMEZCUVVjd1FW?=
 =?utf-8?B?bFJRbmxCU0ZsQldsRkNjMEZIZDBGWWQwSjNRVWhKUVdKM1FuRkJSMVZCV1hk?=
 =?utf-8?B?Q01FRkdPRUZpWjBKb1FVY3dRVnBSUW5wQlJqaEJZMmRDYkVGSVRVRmtRVUo1?=
 =?utf-8?B?UVVkclFWbDNRakJCUjFWQldrRkNaa0ZITUVGWlVVSjVRVWhaUVZwUlFuTkJS?=
 =?utf-8?B?M2RCV0hkQ2RrRklTVUZZZDBKb1FVaEpRV0pSUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJRVUZCUVVOQlFVRkJRVUZE?=
 =?utf-8?B?WlVGQlFVRmlVVUpvUVVoSlFXUm5RbXhCUjNkQllrRkNaa0ZJVVVGYVVVSjVR?=
 =?utf-8?B?VWN3UVdGUlFuVkJTRlZCWTNkQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFrRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkpRVUZCUVVGQlNqUkJRVUZDZEVGSFJVRmpaMEl5UVVkVlFXSkJRbk5CUmpo?=
 =?utf-8?B?QlpIZENka0ZJU1VGYVFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVVZC?=
 =?utf-8?Q?QUFBQUFBQUFBZ0FBQUFBQSIvPjwvbWV0YT4=3D?=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|DM6PR18MB3507:EE_
x-ms-office365-filtering-correlation-id: 740a624f-56cf-47db-3d03-08db9c9d440a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ujz2OCrOR0QQC844CXQ9lMPkKEVKm0EmcPtTox7sQtDmxXWppSV0x6zJj3dx0B82wFAkS977Jvtjgsy0gdiKmhQvVuWLNZtjM/8w5cxwSNJgjZGplNv414PH9VRxhHfhq5oPFR6gxd1W+wnNNZRDKp3pL1KbCBypTBfEhcbFWEHFHSbQ0RoizWZm7SwETYqMOHcFzQ0FLoWeiBEa2ViOhY4O3kPLN2aKkN069G5nmZU0qtgZeW0VcBpRUBQ4Ug3MxIURxstzJOuNMI2D+/KVAbLTyjrCJhVLpmmO62B8dSEjYcLfgdqEcZAg7fgNSc/3T73t/5OIsFtPvnIZxUGT/yAMlFVf7lVPM4WAo4t15Z6dvoz5mu8dxXlOmjK5NRi1SqlFPgbV5N/9ROIBAXxQmPton3CP4GnTHBL+VqvvXl/cLgYAot8QjdCPO+NDPlYRkBVPHARWeasLjQPa5e0Yx9ZhBV4ho7am2ZEXfFHFABFN1V/5tQRPr/dBDWQLK0V8TvkZL0vpnKKQ9z+o//hjjc+VL5DETr8Goqc62lWuD2Nc3wdv/JiuS7Quj5OjfWb1b8nzWvCAqfCb7ZCL7KC9IMKY5e6Qtc/mL8ivMWIul1k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(366004)(39850400004)(396003)(186006)(451199021)(1800799006)(66946007)(66556008)(64756008)(66476007)(66446008)(76116006)(316002)(41300700001)(110136005)(54906003)(8936002)(8676002)(52536014)(5660300002)(478600001)(2906002)(71200400001)(7406005)(7416002)(966005)(6506007)(55236004)(7336002)(4744005)(9686003)(7366002)(83380400001)(26005)(7696005)(4326008)(55016003)(38070700005)(38100700002)(122000001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak1yT3JQNmJFTVRpSVZUM1puRlFzVndjbUpmQnVyemJEM2xWYWFmQzU1c0Vw?=
 =?utf-8?B?ZGcvNmFGYjRSUmZSZlRyZkJySzNRUlJDV3JsU2JxMjVFQjg3MGxSU1YyWXpq?=
 =?utf-8?B?RmdqZWFRdmVnQnVpK29EajFMVXRzZGVZcnM4YU5qSkF5MHV6cTgzWGtpVGZi?=
 =?utf-8?B?MHRvb014bXd5bURTRnF4cU1UbGRGWHlKVk9kZktuUjdqZ2NpUUFNdXZaUW5u?=
 =?utf-8?B?OVdocWoyUUEzank4Rk9zTHU4Zm0zanBVTnJrenh4b0NLdWlKV2hqcnpEcmNm?=
 =?utf-8?B?ZDdYQkFneWJkMGhIZEpXTC9FeDlpdlZGVllBcFlCSVhBNW9QcGRnM3BNc1Vh?=
 =?utf-8?B?SUhHVzJCVWdwTzRIeVFpRDJXR1BXTlFkTlZsT2lEZXM0ZTNuR25NYUJIczZS?=
 =?utf-8?B?U2VPWjc0NS9GQzA1TXVQTHIwMGdwRldXZ2Rob0JaOE1sQmFhL0loOWFsN2h1?=
 =?utf-8?B?b3JNbUZFY1lFV2NrN3oyWjI5VDlOQy9sUEk3VmphRlRHK2h2YTA0L3l0RlRO?=
 =?utf-8?B?bGY4TGZCM0RsVE9UL3NWUUx5S2lQU0hLSUE3RCtDdDNNYThQYkNoa2ZRUEJv?=
 =?utf-8?B?ZlNxemp3dzBYcWs1ano3YnhxR0ZiTTFJN0x5ZGNYVTg1L0pZUmllN0xFK3VL?=
 =?utf-8?B?Z0ZrOTVGeFJ1aTgwMVN5eWNydVhjVWR1ckE3ZEFJbCtqVDdCMTB3SU1yamRZ?=
 =?utf-8?B?Y1VPUW5RSlorbDYyYjZtY2tGN0NtRjRqbER2Ni9NTjZ0KzRRQTN6WEYwRjZP?=
 =?utf-8?B?MW1RbUhrSDZ2N2lWR2t0eW9ydXpvTkZtcDRnb0gvSHZpV0o3Y20waFFmL2xk?=
 =?utf-8?B?NitxRURxSkQrTm13WWhSOTQ1TXJRUkpROUtxcG5uSkF2bWNYQ0F4UVgvUC9X?=
 =?utf-8?B?RnpiYVhJYkxFK2ZDdnpQY29LMXlJcHRuTFJlaVpuT3kyTUdnMC9XYVl4VFho?=
 =?utf-8?B?cWhYVlcwekNsR245Vk5xL0ZYN1AxUmt1WVdUc0VkYnVnQ1NQL2hhVmh1MVBW?=
 =?utf-8?B?aXJYTTlWcjA2aHIvN01HVDlwSDJ5UWVjQ2dBelBYZG5UYW00UG1GcVdBLzh2?=
 =?utf-8?B?cTVEVVN5OStudTBXU2czU212ZDVLcDFEMDhOZmI4U0k5OUM3MENZbEkvVzkr?=
 =?utf-8?B?K2J6SzY2azJGWFQvcDI3dHBVenAvSVJEQXdmbzNkRFNhNDFxREhNUXFMVFVm?=
 =?utf-8?B?RE5LdUtBSUtGOFgwK1RVYm9GVUxxVGZDcWdZbXJmU3JWT1pENTF0aDNlZXcw?=
 =?utf-8?B?ajRuWDRaOU44bG9wSTd2VHVNK20vbkJQakQ5cGFzbjNNV0owaUdWalZzb0Zo?=
 =?utf-8?B?TXg5RmJ2SXlVYnlmd05wN2N3dFhlMzFJZnBUZnhodEtLZWtwV0RKMUZuaGEw?=
 =?utf-8?B?NWM3TjVRMTNhRXVMa09IV2hpTDZjeUdzYkVkdWREQnhoYTlndnB4Ym5sQWZv?=
 =?utf-8?B?dVdITDVtVEd4cUtUeVZLTDdvZ0FyY2p0amwvazFxRmZuaWpuK1hKSDl0OUVu?=
 =?utf-8?B?ZHdtNVBtTzFETzk4UmhOdDJQdzNna1gySlB1SDkxb3lEd0JHbkRDTUF2MlJQ?=
 =?utf-8?B?WlJlY0psWWdlZnh1bENYSmVSUnV3Sm4xaDQvQnRzMmJxa2JNUEhMUi9EYzlF?=
 =?utf-8?B?SW1MSXB2Z2gzZGZoZUZtLzVvV2x2bDh2elBtaTFDTUFmeDR2aElGYThZN3ps?=
 =?utf-8?B?L0c1bVpOWVlNbm1YVEpUNm5NUXdmZWdSaGM3SWtkR1dRNEtoWDljT3J2bktL?=
 =?utf-8?B?SVVEc3VCeUVKbVZycmlhSi9Va1FyWHFhc0JDemFERDJDKzRXbGw3NGd0amor?=
 =?utf-8?B?QXZpSlVuenovUU1SaHpvVFp4RG5Ub09VOFo4bERQVE9VT1VTRE5hb0FoNXN3?=
 =?utf-8?B?N2UxUDgvK0drYWUzbXRiRHVHRUlRUzRxVVJCM0h5YkVadGlzM2ZLVm0yZW50?=
 =?utf-8?B?bUxRSGZRNnRGN0ltd0E2UHZGd3hsT0RORkkxSXAxMUcwL3k3Rys1d29YbjND?=
 =?utf-8?B?Q0J0TWN1QnNlYzJQWHBDZEcxTnlWRzZtdkxuRm5qaEtTWmxuTVB2UVB4SEFI?=
 =?utf-8?B?amVlanZVRHkwOFVqNDF6cUIzczlvTG53aEJSbldxVVEvYTZreGJ3czZDWnBC?=
 =?utf-8?Q?gA6A5vGoTgksJG/1/TOP3Vr1y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 740a624f-56cf-47db-3d03-08db9c9d440a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2023 08:05:46.7992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPMmaPOfIX+xHnwbaVneNMpzPAc0yne+QKUTRzXlrjlzZYMqDb/s7w6evGac8HC8uA/V/pgkkts5Oa/n9XzoQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3507
X-Proofpoint-GUID: FiRs9-tZjKzgFawgfa5AMoirY-v23In5
X-Proofpoint-ORIG-GUID: FiRs9-tZjKzgFawgfa5AMoirY-v23In5
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

PiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTdWJq
ZWN0OiBbRVhUXSBSZTogW1BBVENIIHYxIG5ldF0gcGFnZV9wb29sOiBDYXAgcXVldWUgc2l6ZSB0
byAzMmsuDQo+ID4gUGxlYXNlIGZpbmQgZGlzY3Vzc2lvbiBhdA0KPiA+IGh0dHBzOi8vdXJsZGVm
ZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbG9yZS5rZXJuZWwub3JnX2wN
Cj4gPg0KPiBJJ20gbm90IHRoZSBvbmUgd2hvJ3MgZ29pbmcgdG8gYXBwbHkgdGhpcywgYnV0IGhv
bmVzdGx5LCBJIGRvbid0IHRoaW5rIHRoYXQgd2lsbA0KPiB3b3JrIGFzIGEgY29tbWl0IG1lc3Nh
Z2UgZm9yIHN1Y2ggYSBjaGFuZ2UgLi4uDQo+IFN1cmUsIGxpbmsgdG8gaXQgYnkgYWxsIG1lYW5z
LCBidXQgYWxzbyBzdW1tYXJpemUgaXQgYW5kIG1ha2Ugc2Vuc2Ugb2YgaXQgZm9yDQo+IHRoZSBj
b21taXQgbWVzc2FnZT8NCg0KV2h5IGRvIHlvdSB0aGluayBpdCB3aWxsIG5vdCB3b3JrID8uIFRo
ZXJlIGlzIGEgbG9uZyBkaXNjdXNzaW9uIGFib3V0IHByb3MgYW5kIGNvbnMgb2YgZGlmZmVyZW50
IGFwcHJvYWNoZXMgYnkgDQpQYWdlIHBvb2wgbWFpbnRhaW5lcnMgaW4gdGhlIGRpc2N1c3Npb24g
bGluay4gIEhvd2V2ZXIgSSAgc3VtbWFyaXplIGl0IGhlcmUsIGFzIGNvbW1pdCBtZXNzYWdlLCBp
dCB3aWxsIA0KTGVhZCB0byBzb21lIG1vcmUgcXVlc3Rpb25zIGJ5IHJldmlld2Vycy4gDQoNCi1S
YXRoZWVzaA0KDQogDQogDQoNCg==
