Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0955F4C96F6
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 21:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238093AbiCAUcN (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 15:32:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238414AbiCAUcI (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 15:32:08 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2110.outbound.protection.outlook.com [40.107.223.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357FE85977;
        Tue,  1 Mar 2022 12:29:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U87qS8GG8m1G9MZbGUMYNlM2ZcBjZx9+TklUm3uISFAMR94q1CTXFs8hZi8bj7W4nPbid0pIdHjhsSxnjrsKmd+6EIbSy3K7gXDkMGnlOm2aH8sDlmHU5GacSdu5WRxCBXfQiBwx6wAzAw2VXcRQKvf5HpvichCYILRn0yTfAClvd8SezCygUblcnngSnf85LWYM0E6iv1kQ3NtazY2TxZ/qnaCiBr0I9APSjpp4j2ZDlOcLTx7NNaWhsc7tJJVVmTsDhv+OoPDSFzrtynSApsBXgxlw4jtTnRI6XF3g3fuBfSPucXKh50ImWk2dpnRb1N88yqFC/bBsRtAFYSrCig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frP5s5oqBi/QHJ6QnYW7RMskpZUVopl3Yz3knq1zhDQ=;
 b=m/LwKVkfSBu8Y1Xhsuw2BlaRce96kO43n7cCuTDPlEIh3uUH1qAzi1cG9CgC2Id9LkpffGw4OVIdVpjvEPgYpwMLIVjrEoQb+xn1PW1K6uPJRM9u3AKDhU7NuawH4iCXoi3VWr68SdiA1vwKt8g/PUzaFYL/yyy28o28chCGEe35bzJDu9F/YXR8quQTq0bVS/wYFkDyB235251KrbPk2x7gyaNlZNCLFtaR2PY9lcCkpNmj6ST7MrEDkT/ew/EnpKhmG7MUqVTHm5oZGiUzmYn7VepBm6X++86Pwfit+tQTejhLB4yktGlF6NfVyyBKJWwO9EVb4QZfiHzR8Dgaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=frP5s5oqBi/QHJ6QnYW7RMskpZUVopl3Yz3knq1zhDQ=;
 b=A08GriZRQPlksk2O7mh3H9mAA5HZRHpvSX5V9wzfQTGzfpR/1xYvTZF+lwK3WbTaYJcq7Hf1cM0Z/o/kmi5JT+UK/4VyHn7OP7NfXh/tjXGdkof6Jelc5AdsjbsmG1qsDOGGh0ZUJzR/9V5KbalIBLnJ3qUMDWC3BzhWmHLoPL0=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by MW4PR21MB2026.namprd21.prod.outlook.com (2603:10b6:303:11d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.0; Tue, 1 Mar
 2022 20:29:43 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::2c19:828c:362d:9e4]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::2c19:828c:362d:9e4%9]) with mapi id 15.20.5061.003; Tue, 1 Mar 2022
 20:29:43 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Drivers: hv: vmbus: Deactivate sysctl_record_panic_msg by
 default in isolated guests
Thread-Topic: [PATCH] Drivers: hv: vmbus: Deactivate sysctl_record_panic_msg
 by default in isolated guests
Thread-Index: AQHYLXZ+YI63jvIIMEaVFeDJ+Co9ZKyq+jSw
Date:   Tue, 1 Mar 2022 20:29:43 +0000
Message-ID: <BYAPR21MB1270C0B7E709B218E67B0D32BF029@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <20220301141135.2232-1-parri.andrea@gmail.com>
In-Reply-To: <20220301141135.2232-1-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=232c3d4e-34c2-4d8c-8da0-474eb5071206;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-03-01T20:26:00Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a207cb2-af35-453e-25f0-08d9fbc23863
x-ms-traffictypediagnostic: MW4PR21MB2026:EE_
x-ms-exchange-atpmessageproperties: SA|SL
x-microsoft-antispam-prvs: <MW4PR21MB20262B6057EA9778BA1CAE44BF029@MW4PR21MB2026.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uBK7k0FAqf/+jeDhZl9+hrttknmVTOpL/D4Ai/8Hka8FcWYmcLx+yinoQ4iv9J8P0xqE3ysWf+ZpAusFOWzMZcXA/1KsA2dPDxx/1Txwzh25o/Zj+DNO1BfQxheUkKE+iy2e3Xsx9Wjn/2YJviZgqORH/yagL/SObKzxxyVgzGbFozHg1JEgB54cgwClnSNi2jLEjewuTVj2Pg9XPIk5TbS1gmevw6b+YPPKP7Mf09RuRWQ7/MxQEJuTDjbkF/WYeAqhuq0o2r07weDWfsGCuROaJT1Ovh96D9/4u3ce4s397a6pm5wgKVkPCroYrZL9TLokVvQQXk8r/qgYu/x6EjIEHcV7DJpaCxY+J0yGJfWXOxoTx+ZvFbHNL0vXElCs5D0jTjbNYpR2/5ak4lEBX5XW1fFZvnMDE/r72tjHe6A8FVg0+wPHPl00MUTaX/MkT4mD7vM9wFYNm7a1y4DJEYlHrohAZS8ESL0cdRCVH3IQt0OidfxZz8/AV6oZSZam10NDZm1WbXSNp0gWRcdBWOo1ZESCXJvpGog0+Y5ICauz1LIqQFCcJ5tRgTEQMx8qU/REBSBh6H1Jm8DJg6CTlSC7ax9ZqGZ47JHDuQR20N1ZASyNghwXPYLIy+F0TUzaIermn5zZpK4ekbaONaCKefPvhpC+3vifrQTUf1gJ+zRuAInQyKprkNVXNqZR4AByO0HdOhACqf4LZnRz9yJNtvsqxpIVDXNa6AgDsPT01LNh0QlOModXIw7PRHbl9iBx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(38100700002)(52536014)(6506007)(64756008)(66556008)(66946007)(110136005)(55016003)(76116006)(66446008)(122000001)(82950400001)(82960400001)(38070700005)(66476007)(8676002)(4326008)(54906003)(2906002)(6636002)(5660300002)(4744005)(10290500003)(83380400001)(8936002)(8990500004)(7696005)(33656002)(86362001)(9686003)(71200400001)(508600001)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eQPMdpKlcopXkwjmlzrsFMdKw1YucpWcgeSkll4DPCRkQiRwnfQ1EkyWo09W?=
 =?us-ascii?Q?fwOOYpkuKV/TfRKg6nmrc8NEVKA1Hltaz4mA6rVSzG+cM7/1UA52/AqXX7Ov?=
 =?us-ascii?Q?vF/pL0rB+6HjqR+f/R351spteJH5Zo/8q5a3IBrEX/Rsm1OCWF92kxGbGsca?=
 =?us-ascii?Q?1g00fj3bwqo7JFrfVK1bMuFqd2Tp6NKRcOH1ET8Wj2P6QNgMmzPtzfYZ+H+G?=
 =?us-ascii?Q?D86fydVlLTgFWDzcG4LBF5Ei1nGueWJU57J25FWdeVxsUF2bUjk1kK+sCaaT?=
 =?us-ascii?Q?6BMu4m9ong1JVKREKw7TJv6ciHqrQsfLL6aX/ZZAqwDHrBlDuT9RRzhoXAZx?=
 =?us-ascii?Q?bHKVdMeZwLD/UnIBFeKKTEEu8NYDugkjQFbvTMuREEErs+KyJLQkNZEaQjoH?=
 =?us-ascii?Q?RZKHedp6VOnVSmCRVcTJgzVHVyvXG++64LIYU2uMzNoV7+QKq98IZ9JOQLBt?=
 =?us-ascii?Q?JYi7cGA6W6ptVo3YKb7Sc3WTYipUG0oUcEIMoGgOnSDXyZEJjwtlz7ixALKF?=
 =?us-ascii?Q?EuScHdr9B5mX+1FOzs9+ANYxcZOvt4j8+SXMSdqjdC/tplRUWnmK68evmvTm?=
 =?us-ascii?Q?Aw2/Lb3II+Bf+UyPXQhTa2CC8S6EeHP4RDQTQgqfUCxDY0jPSTFDjxM4Ps0I?=
 =?us-ascii?Q?3hWsGYJxvUaV5P7SudoOklA4ey0AKQNBOosllr67yPPFJ6Nlz5RDt9ykldxo?=
 =?us-ascii?Q?YbLRv+l6f/rZZhVycvBWL5ryhG7BdPfF55Wt280XKamhkSgEr4HwElQqyrh5?=
 =?us-ascii?Q?e6OB40uVOw/bgkvLRgTDDFEHs/40OOUWNQWutKF+dbB5Mk6GMtKhm4pjOz9F?=
 =?us-ascii?Q?pgU1GlDAjkKxCtYt62c0mtMSgla6SSPj9qcIIj8pxVO1mCWEaKfQaGHyzI1W?=
 =?us-ascii?Q?gVPhikcXX7xQ7IB+95x7HXwUEtHnVT5E7o1Lku7+DvgrkJJBug/6bgHE1rl4?=
 =?us-ascii?Q?IrjSU7FQKaw2Tt7Osc6LPlRj3WnApVgv2IgCXCcyrucR9gcDHO0djcyWR5mm?=
 =?us-ascii?Q?zdBqwuT2VwMed2g0RiW/AKGGGv7yU1vjirdJ1ssjngOIN1NEISUFt6bNOHOs?=
 =?us-ascii?Q?uZAKxJRlmPnmq6WU3WqW587Km6xRVRtafmJe9wKurw7zl+jb1jg7PMx/UYsN?=
 =?us-ascii?Q?kG9OBIitAYXYKrgekISRfuXgCT8SoDOj8kqw3nU53p7jpi3l+CNxTttIeoHw?=
 =?us-ascii?Q?mK4cMwel/sHlblCkJxPVaCjK3bLPew2mCpVlvI6mqhRKXBdGvMd5jc8tqr7I?=
 =?us-ascii?Q?x8TZ7qghfY3PtuAGAVZCkd71CXK8UTmS5hfbjXf7uiUqS3iuugjfs8KcwZVK?=
 =?us-ascii?Q?qag1YUgPlz5Onob3gQ1rYgTY3iAgK6CCiDJMMCdquEb0bAWLDHPfYi1hg5fJ?=
 =?us-ascii?Q?RZsnBo2I9fjaHxtdDjEOvwQrDlyuPIbBqn63NkgXpKApDJasyJLpZxxiwiT/?=
 =?us-ascii?Q?j7kBgYS9sqhfnSYW5MKnAqB4Vc8crujG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a207cb2-af35-453e-25f0-08d9fbc23863
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 20:29:43.5885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ivfa6jrkhFmLiBToY8pk0VA/zWLOTzVR740t4Nb6lt0WqKAsI3XiZ4CiGyNNWYYUCTPx+ZIB17Ap3ibC3GtBjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB2026
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Sent: Tuesday, March 1, 2022 6:12 AM
> ...
> hv_panic_page might contain guest-sensitive information, do not dump it
> over to Hyper-V by default in isolated guests.
>=20
> While at it, update some comments in hyperv_{panic,die}_event().
>=20
> Reported-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---

Reviewed-by: Dexuan Cui <decui@microsoft.com>
