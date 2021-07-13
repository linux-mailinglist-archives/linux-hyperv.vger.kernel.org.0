Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45FA3C75A6
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jul 2021 19:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhGMRZ0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 13 Jul 2021 13:25:26 -0400
Received: from mail-mw2nam10on2091.outbound.protection.outlook.com ([40.107.94.91]:40032
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229454AbhGMRZ0 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 13 Jul 2021 13:25:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8YSjo7hBF1+wWLt1dy9sw1c0vZjZvxJq6SAfLFXWhNNDcd0tOoGdXA/N3L5KMCZhrZsn1IDUM3hhNinHWwVWa4g01HBLSvYuiBFKFMcKurWQzvUqAAXtnDF3vNvOeOpWaGVD2hb2Vhy2HbSnZR4dXButjXd1vzU+Ys96Xl8973Hzma9Ny3VQGjdKK8XUdbuToOOQ5QEdpM2WZJDJr2gDvgBoCAzbPp+8zrxKdtuJQC0cxB1JuEiDnvubnRR9gLq9O7Q5+XuFllT7BPtwBuGZZSIUwf3AXlgArWFTaYQLN/ObGaLPGjm7hI3TbZ+mFC+fgY+4qywyBuyXFhSksIEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aOwDl8Zbc6ewV3PF0X8up+7XQvWZDaZlUqCc9pIY2I=;
 b=DSzWYlWVDpMKIgmv7ChxXlpnTjSi01D0AsoQwo29QN33ZERUoFJDwzDi8ZVdWifWQ1ZyZ6Ek9Gf0xRjcu3KtD8SibxezqR/TiQAfJIWy+F4BqV9R9+cE6x1plWtEEoFKlH7FBlnUGL3N9iYOfIStvD7uBVLFkzpo47EA6EgkY+EXXe9iuYxjaYCeERjLjO8OcYdyt8G1VgeSI4lyi28Vjxl//J5YWhcGlbJAUQn/e0d4n6a+CeV6y12Lqr4ZHgoqVus04GEAdSD5s6naDBF5f3of/uteuAr2WKBjLEG1zuhM72Yz2ehs4/n+9E6hn+a9FzCx2u0imFlhI2zK40GLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aOwDl8Zbc6ewV3PF0X8up+7XQvWZDaZlUqCc9pIY2I=;
 b=CcqgvqEmoxiP8jRSntdHKVMPV8Rg24tH1o/1ZHyufq7ZMvOMt+/EKnbt55SmS/DcV82mkvfYt9bWBhooA3Et5eiAhJpCmImCbnh9Hi8YmSs7Kh7yYbc9d5zb31cHQe6Y/r1hx4TpkNj1Jqnsmp7gdvbcLem8If0UVtp7CFlRRzY=
Received: from CY4PR21MB1586.namprd21.prod.outlook.com (2603:10b6:910:90::10)
 by CY4PR21MB0855.namprd21.prod.outlook.com (2603:10b6:903:b9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2; Tue, 13 Jul
 2021 17:22:34 +0000
Received: from CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3583:7ddf:dc7c:b25f]) by CY4PR21MB1586.namprd21.prod.outlook.com
 ([fe80::3583:7ddf:dc7c:b25f%4]) with mapi id 15.20.4352.008; Tue, 13 Jul 2021
 17:22:34 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>, Dexuan Cui <decui@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: RE: [PATCH v3 1/1] PCI: hv: Support for create interrupt v3
Thread-Topic: [PATCH v3 1/1] PCI: hv: Support for create interrupt v3
Thread-Index: Add3aLOcHePYP261SY2/sMpJ3p6saAAot+Pg
Date:   Tue, 13 Jul 2021 17:22:34 +0000
Message-ID: <CY4PR21MB1586D8027E841DC35160FEE7D7149@CY4PR21MB1586.namprd21.prod.outlook.com>
References: <MW4PR21MB20026A6EA554A0B9EC696AA8C0159@MW4PR21MB2002.namprd21.prod.outlook.com>
In-Reply-To: <MW4PR21MB20026A6EA554A0B9EC696AA8C0159@MW4PR21MB2002.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b218eda6-6ec3-49f3-a323-bb5b0f0c0d43;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-13T17:21:53Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d8b3e4c-bfaa-4ca5-40e7-08d94622cda3
x-ms-traffictypediagnostic: CY4PR21MB0855:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB0855A0F066FFF81355EE4D24D7149@CY4PR21MB0855.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WyHmJ8rcG7Z8/V+DmXtqTVX7PWaV7c9nImn9N3aIbazt0XNsIw9hkxAY+sRg3qK9aO7vjl5+XVuSX9JHMYWv/whm0T+sypD/YAbiD4A1dJy7HOjrVdTi13zXRtj2Fptpr8bs7WghIp2Uf/t6JG4yaKwEknQEDb5dvYXVpILb9gmIyLBaCR+y2ZKqfTtgMFlhRW1DyI9OWuImYDS47UHBazejA3iYqv/PLBMlzeHJmAlEX7fGRQ+8O7Z/OWD2WzFlH4zdVkt2PqYzCBJ0ObzBwIbu7IeL04Sg9Wptjl7DYJZ/dlXIcaUcd1uBogpM6BPdifgknCpN9oMkQWLN5jaAzZ3R7Lzx8tU+I2Zz20P3x48e8RyGG+ZSzaU803SiCs5nZ61UbcVdvNipM++LtpDUMMM8/9Y4ObQ5cOjT2cdnqKSoT/nqJEgkGcjNsPgjL74KmS2QeqCRcaLDfNPuXUkqQ5kFqLNS5PZagkkfoJPTmuxmPTiu3EGv4ofhweRp2sptKil0h/2Rre/Y5C6YjVysqHckHD6nkZp6DaLq9QRyyLmlT3uHXBL3JKm1ke5oMlhO9fHAd/2Z2m2ioUsG5zehIH8PXet0eYv3fQsjBGU9MWMTOHoY68PP0IPtbd6ARNOCBj/EiY4ewp5ySE7YXeYMTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR21MB1586.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(86362001)(71200400001)(6636002)(9686003)(4744005)(110136005)(64756008)(66476007)(8936002)(66556008)(82950400001)(7696005)(122000001)(55016002)(82960400001)(52536014)(66946007)(8990500004)(4326008)(6506007)(8676002)(26005)(66446008)(186003)(76116006)(33656002)(10290500003)(54906003)(478600001)(316002)(2906002)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?x86sPPKDNKWyIIpwqUqwG0c20sRSyg/UgXoSN0LcZL3xJDh+qEzA7zUZaA/r?=
 =?us-ascii?Q?Yobr+m1HKpE+9kLdMWveBqmpr4XLoaAwZGvt23T6iynZ5UOPJmDMi4zzWROh?=
 =?us-ascii?Q?TxP5HZQ5HX4/cfPAK3t9pOLoLhY1o6l39Gb2pKW27EZ6Jhnxmbt2gdRAgRww?=
 =?us-ascii?Q?ew2XUAKf2ZBsVFTv7ykfm0kfSPTOBD8EiMOi+RbUXNcx2CgDTvSIFNt7csdG?=
 =?us-ascii?Q?wpH2h0AmB7q3g108HSPYwkqT/3BZRAbnqYjBcOgrsouO2/zCoZJy1+7yLNCo?=
 =?us-ascii?Q?laCTkZ7ioW8VgFiBFjfDoDefejE9eCrYRTBkJg85XTJtGZdNfiPnLEm/IcXi?=
 =?us-ascii?Q?v3zhxFwbxs3SxvjvDMEiJ0mCG9hQhH4ZDei9k2eNt+QnEj43Rv1UDElXtrw1?=
 =?us-ascii?Q?4flQ4IzXYwPWxTSQz9nhW5nhzGFsM7BqNpSqeYDVcTk/51UdCjayJ6mCC9h5?=
 =?us-ascii?Q?+7IYBUSmjhbwIiYnPv//5ZS9qCLaL6Ku9VcLYdyVYWCCWmBLH53lVa1ZIS4s?=
 =?us-ascii?Q?xFEC8vYclsXEUpnVStHxVxxj/aXP7v5Hd5gp9TMZNiYQ/Rl73u1HS0txyulq?=
 =?us-ascii?Q?kRi1QpUPc2vZEiy7ZU3NryvLcz9Y//voX7b0B+8DjSk0RQWEvMlWUKmLEL2b?=
 =?us-ascii?Q?Bp/onXbsSeeWDeTeKIQVMPGSXIXprGhZMRqNB4Fg1qS6q0poU0Z9YBPPgaQs?=
 =?us-ascii?Q?qFRYH0OsqD/DeWs35IkNCX9DqKWFO8HsRLlEtPNHivQjPXBmsigzcZWlMqBi?=
 =?us-ascii?Q?sge/JOWbf8qAMrqrkLybbRxz8eSG/18I+EK4DyIFBK7ZfmDYF/9Dmv6xMz/x?=
 =?us-ascii?Q?8ZeAkoY3+DrJTQpj/jEw1wNzB6EgkLSeJVW3WxhHqv4hzmjv9thvI8dOBPFI?=
 =?us-ascii?Q?Jgf3c9PQJ197TCreyzoXLALbhqr3jJlKaqhVICf5bPzceTk/yN4xFvvDMV8E?=
 =?us-ascii?Q?JeLXXpk+iu26GdjDcrWe3q/tPbk4bZU0xKnpNUJ6dVnxOV74sGaw5xeeHSRN?=
 =?us-ascii?Q?I4sfPMmtOD2RbYYws8ZL52ku+nNulHlwlYPgj8QaEopLVftjmU5+9eXE3hdk?=
 =?us-ascii?Q?K7W/i7Mgk6jTroxOb+m6EtmLrhbJsK5VY5T87J699ZeQ62UoX3Rjjq7NxjoK?=
 =?us-ascii?Q?YT43rNxuMJGMxxJ6D5D3zNtLUfY3lFj6/PYPja8Bp7nZDY6bZ95Scj28+J7u?=
 =?us-ascii?Q?qDwKuWGAOZU7M1zfYNBfIU2unZCwk5SxFnEVOPl0Z7RBqkQGEl5KDq7GtZVR?=
 =?us-ascii?Q?1eyl1+rJ2Se/1CJDitt74HkbL8k+DG/C/xKNiMtIZXsnfGDHx/F5yMs6uAk7?=
 =?us-ascii?Q?1B8/JUe0qE8IRaG8QHvQ0DwD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR21MB1586.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8b3e4c-bfaa-4ca5-40e7-08d94622cda3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2021 17:22:34.1477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHebbs4ACSeitJ06SgrPnLoXHBV0QbkWhLJ3YSTK5xux5QRx2i9+lE/isp19mn6sV9fNSFFS5NzWp6Sw1XH8qE5jUN2XLPI/gmTNL5Z4ZjY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sunil Muthuswamy <sunilmut@microsoft.com> Sent: Monday, July 12, 2021=
 2:58 PM
>=20
> Hyper-V vPCI protocol version 1_4 adds support for create interrupt
> v3. Create interrupt v3 essentially makes the size of the vector
> field bigger in the message, thereby allowing bigger vector values.
> For example, that will come into play for supporting LPI vectors
> on ARM, which start at 8192.
>=20
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> ---
> In V2:
> - Addressed comment from Wei Liu
>=20
> In V3:
> - Addressed feedback from Michael Kelley about incorrect comments.
> ---
>  drivers/pci/controller/pci-hyperv.c | 67 ++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 5 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
