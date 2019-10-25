Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91932E478B
	for <lists+linux-hyperv@lfdr.de>; Fri, 25 Oct 2019 11:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438755AbfJYJll (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 25 Oct 2019 05:41:41 -0400
Received: from mail-bgr052101135022.outbound.protection.outlook.com ([52.101.135.22]:60302
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2438742AbfJYJll (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 25 Oct 2019 05:41:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FfgabYNezUwQ1gIXhz3sW+bptjeyKxmG8fEQ3rgky/oWYLyMmY3GHQ7HBuhX9vDnv/CUa2dxFr24j5sdyXcOV3ZRcA92YCwMCu1b6gjfcS2IJmgf2ybubVNrbXqVmxzLFr8R/RnvruuaKquccHNJGo/Gp0y8/2gVebt8yiQtOXj/JlAYtD2SV3p+XzqWeqoWCSaiYKn0ecvO/T1kvhkB3ydm5RtiQhyDD5weg8fBbhn7DnvHC9d6ubIFtYioxudlOqB24WTbkVf+YhVHltwGzq7wGNcU+6mToF8FrRyRbF9g7fjZ3pOi7pqmZcn5z+4N5buTbQNOawzQzH4faX0Ixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9fNA/gwh1c5rlTRsFKcaCfh3z1j7Bk1jRP8YxSznfI=;
 b=Ef/rOkdHzpYkA9EgpR8SDuFRmqQXG2/Vvvg3SycEPTtFT5ZxatSQs/J4R1p5tydt385RAKtmizYzcuyY74OU6k5FPrDypjW/rSKv8ygCM4YKX+MWbxbnMmMruqyITr1CfgBKhtqfys4ALmf2R4ddonm+OqPRd3Z/yeyUjjxSvNbQbFNbeR6g1Ijbawad+Nh4LVTV9xcH8VsiEzNbwuBghEVGPwPgt5roqd6LU1UlIc1dHZ7mSu6ksuMbYrWrSMQVXITRSc7cpzVZlQRu9iMsza52ui7jOM453+LaMLNnpZHVZIyhgW6AzSLDm/ESjpKxJhY3RckI75nNW6gFnt/xQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C9fNA/gwh1c5rlTRsFKcaCfh3z1j7Bk1jRP8YxSznfI=;
 b=CH3REHkRn5og89AiV4ik1NErPC4PalSBJp8T8In8x0eiF1psNPKLSVXXGILCIOW6Qr5R/7lz8mhow0JiRMrdmeR/VAxoe3NboBFtMz7Vo1PCHLaz99VOwMMCe97epI2nIZYDQ3ztOgBUIHpgrUj+ic8tc5Knqh7KFOJo7Vw+soo=
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com (10.172.218.15) by
 AM4PR0802MB2322.eurprd08.prod.outlook.com (10.172.219.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Fri, 25 Oct 2019 09:41:28 +0000
Received: from AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89]) by AM4PR0802MB2242.eurprd08.prod.outlook.com
 ([fe80::9c3e:dc5:e056:9f89%12]) with mapi id 15.20.2387.023; Fri, 25 Oct 2019
 09:41:28 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Topic: [PATCH] x86/hyper-v: micro-optimize send_ipi_one case
Thread-Index: AQHVioF8f6JnvYZ8LUKUUp53PHF9w6dp/CAAgABmQ4CAALlWgA==
Date:   Fri, 25 Oct 2019 09:41:28 +0000
Message-ID: <20191025094125.GA23240@rkaganb.sw.ru>
References: <20191024152152.25577-1-vkuznets@redhat.com>
 <20191024163204.GA4673@rkaganb.sw.ru>
 <alpine.DEB.2.21.1910250036090.1783@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1910250036090.1783@nanos.tec.linutronix.de>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.12.1 (2019-06-15)
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,   Thomas Gleixner
 <tglx@linutronix.de>,  Vitaly Kuznetsov <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,      "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger
 <sthemmin@microsoft.com>,      Sasha Levin <sashal@kernel.org>, Ingo Molnar
 <mingo@redhat.com>,    Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>,       Michael Kelley <mikelley@microsoft.com>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::30) To AM4PR0802MB2242.eurprd08.prod.outlook.com
 (2603:10a6:200:5f::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6070eb6-5e61-4734-6316-08d7592f8244
x-ms-traffictypediagnostic: AM4PR0802MB2322:|AM4PR0802MB2322:|AM4PR0802MB2322:
x-microsoft-antispam-prvs: <AM4PR0802MB2322606CF355B0BCEB63C503C9650@AM4PR0802MB2322.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(39850400004)(376002)(366004)(396003)(346002)(136003)(189003)(199004)(2906002)(6436002)(102836004)(386003)(6506007)(66556008)(66446008)(26005)(8936002)(36756003)(8676002)(81166006)(81156014)(64756008)(66476007)(66946007)(5660300002)(478600001)(446003)(71190400001)(7736002)(11346002)(71200400001)(256004)(86362001)(76176011)(66066001)(7416002)(1076003)(4326008)(99286004)(14454004)(3846002)(54906003)(476003)(6116002)(52116002)(305945005)(486006)(4744005)(229853002)(6486002)(58126008)(6246003)(6916009)(186003)(25786009)(33656002)(316002)(9686003)(6512007)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM4PR0802MB2322;H:AM4PR0802MB2242.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-transport-forked: True
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ik242GzpNj0pm4vSnLX3euHgLMtiZiYU+0uNFmnz5sKdOgt2GlapKje0mT7k+xIkyaWxREeIliqMLbP8BGG33QIyWk12cc+K89BW8PeOyRFIVZ5750if83BdMNNH9266cb1jRHvfSuSGjrmCEixXLLqjsTj43OZXrhDCVr0VVDUkOUdf7/t5ixrP3egFWj3Mn/ZKarqknsQsbUWaGD7FaSJNz134K9VRUa5GGnN7LZVlZnjLxgx0uZDIOZyo3zXd1lv0kKDwHd35CJEgwCZz61+nLXurjYq+5MMsbTWurM1HWlQckPn5rV+VWX9kpRvWPnTRI9WKwKd5H/3ps0Szvv5qCuBbQPDl2rwslmJrHjJgGUTn1C1b/UJOEaqPayHf0C2W3d0+EzMjMgnFMfTEaGdtXaQrwvsdx+PbGMtN71+VHymohLSeowO34rZWQuQTvuuuEDWW+Qv533C8nPn+l6g0GgtqzIf6X14enIsVhfWKSQvKCXgd8T0XDYbLd9CyWIItA6t6NFh/QomGWEcWzQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <783196C564771B4B9EE7F464C8909E3F@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6070eb6-5e61-4734-6316-08d7592f8244
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 09:41:28.2088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bQQ+KgNlsz3E21TV0wC4UVPjWbHw0idW0mTIZxdpDAR8a9RpCmGJaDAkPk3ZLHkdA2aciFxrFZMEp55Lt9Etg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2322
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 25, 2019 at 12:38:05AM +0200, Thomas Gleixner wrote:
> On Thu, 24 Oct 2019, Roman Kagan wrote:
> > > +
> > > +	if (cpu >= 64)
> > > +		goto do_ex_hypercall;
> > > +
> > > +	ret = hv_do_fast_hypercall16(HVCALL_SEND_IPI, vector,
> > > +				     BIT_ULL(hv_cpu_number_to_vp_number(cpu)));
> > > +	return ((ret == 0) ? true : false);
> > 
> > D'oh.  Isn't "return ret == 0;" or just "return ret;" good enough?
> 
>    'return ret == 0' != 'return ret'
> 
> !ret perhaps :)

Sure.  Time to vacuum my keyboard ;)

Thanks,
Roman.
