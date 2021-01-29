Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4556630827C
	for <lists+linux-hyperv@lfdr.de>; Fri, 29 Jan 2021 01:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhA2Ahb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 28 Jan 2021 19:37:31 -0500
Received: from mail-dm6nam10on2123.outbound.protection.outlook.com ([40.107.93.123]:46625
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231387AbhA2AhE (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 28 Jan 2021 19:37:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzusrnCTcOtlCMwgvMK9HguzEHqVR/o/nPD4K4r1piBxCpK7714Lfg25uKeAXIBux0Us3lckQ71q2AXsScMINAgPEUQE7aQ5kohV+pdkV09pbBEqxccHp+DWARR8vencieiy23YFd9SsuTAL7CNJzlmaaWXH/LV4WCerTqpYh75u4woW1ja/cASyQtVg037SzU4K1yULEOt6V7fcI8Rtfq4GnTo2Kt4+rLAnGavSMl5SSuHM/44wy6eUjF5c5tkKOvudJubkoIL+IfbCV6wehHCXgw2TAKz56NvTVcpp/LAm6qAYJAgjCsQ/PlBBthS+2D0kEbQSt7UPmlcB2P/Akg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaBEDdWIo/HUIwxdexQNaiSd+fQgcUGUQoqnpGKUc1k=;
 b=Gpm6Q1Jt4MYVzFAMinklRTMKOGz2DAJe/aGn31yZDJv6jA+neGPUfXHTbi39yCwYrHgcQhfdpf/8RhqFp3WrDGhQYsHwbxmVOP/3Lo7lYi0lW5GNvriPR1jH5m9q/W7iq1QFDKvSL2Gpc3LFog/xBWPHWlFqMePsJIbsi3ql9uK4N+a+MAjaI3DHShsRlMOWiHTZPVy9cCKoWa8/p0pd0jzfSm6FtNAbZpFvCwbiZqx8q3f8keYC+BDTU5b806bfWKV3oyVRZe1XEmb1kYDesYtmIWEII1PlF4Co8EzGjBcrZ5Hc1wLv0CrHpi7X9mVka5yB35j8pxCzm6eMw0cEiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaBEDdWIo/HUIwxdexQNaiSd+fQgcUGUQoqnpGKUc1k=;
 b=QQqxuxOjvgXRg+Dph9FNxZK3eSGE4CkS41Obpr998x+ePJTv8MdlpoptPje49IwB/30l3oDUdn4AGHDZPJtoVguLphpdMADdvJEJ59345Mniu/PSRrp25S//caPdFmTjIOBsOrqpUp03zDEmUkrfotQJGxpnPTV9hP0eJIhD8/E=
Received: from (2603:10b6:301:7c::11) by
 MW2PR2101MB1019.namprd21.prod.outlook.com (2603:10b6:302:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Fri, 29 Jan
 2021 00:36:32 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Fri, 29 Jan 2021
 00:36:32 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: RE: [PATCH v2 3/4] Drivers: hv: vmbus: Enforce 'VMBus version >= 5.2'
 on isolated guests
Thread-Topic: [PATCH v2 3/4] Drivers: hv: vmbus: Enforce 'VMBus version >=
 5.2' on isolated guests
Thread-Index: AQHW89pmofE0oPLg9UyNkkZnhDFCpao9ubpQ
Date:   Fri, 29 Jan 2021 00:36:31 +0000
Message-ID: <MWHPR21MB15935A546E94ACD68B89FFD7D7B99@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210126115641.2527-1-parri.andrea@gmail.com>
 <20210126115641.2527-4-parri.andrea@gmail.com>
In-Reply-To: <20210126115641.2527-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-29T00:36:24Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0b8d0339-a684-40ee-bb85-3aa759cfcf96;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [8.46.75.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb4789cb-af07-4719-7fba-08d8c3edecd5
x-ms-traffictypediagnostic: MW2PR2101MB1019:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB101969EDF9D9276B863790A9D7B99@MW2PR2101MB1019.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I7RglkLsUrJeq1pKjC4uWY7epPrkyRSUhTtBzyB67zS80KoptiEQe6uvhgix30QgXIAsMh+C6QWE00kisfOn9/s8Ll9+dMdG9GtKkFaO2ChDdMUxacs/cHcos8Q98wE7bCm+inN2OxuRrmc3ek5Q1QzM9E62LwL5kU9Vn5wMerrZKejuEDKijEPM4AEYId/5aVtMZagdqlysidD3lEGNr5WYl8ScIAoUwTWDXkkm8zz1qv3GkIk+FyahCOkViRxg7w8GNdI5FwgFDr4/ohd3YgFJnKD5QEipqTffY7KSW1t2KAGmRmMQJlyae5MZbQgjR9NgYvM6Sa6d5UC2AhgQQI/lcijBUDL8AI7MCGn4oKrq8Xw4BBbq6LhQpBQbTo9KFCoZahoZbsjQZ748pMAH15LVP8UyOTa9PuZUQDQ3cw+31fGUeclQ5BDCanMQZofVnX1saHX9pbWOvBN64xBdBsA5mVAe6/6MserHKQjj4MRvZOMxHxNsz1nZ7e2JPzWBDtuPDm7Tcy9KPpcn8C026Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(6506007)(64756008)(66476007)(55016002)(66946007)(7696005)(76116006)(478600001)(110136005)(8676002)(8990500004)(66446008)(83380400001)(33656002)(107886003)(9686003)(71200400001)(52536014)(316002)(66556008)(5660300002)(82950400001)(10290500003)(82960400001)(86362001)(54906003)(4326008)(186003)(26005)(2906002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?S4fLq/3oBwTitXTFeh26Y84OGbvNK5bFrdNE6rCghQI2RsID/PeQtZ1HXAxn?=
 =?us-ascii?Q?JY4tuA3/IdWPByJgMPvooLn+0BXaUdg6rgcphAScyhSYcu83o0LPh9EF2tpM?=
 =?us-ascii?Q?JqAsPllIk0U1GPzkKN8LmW/ys1VvUVtAC8g4xlBNgrmq43FvopnZJ9CffW8S?=
 =?us-ascii?Q?NyiwIav8zUzOTzoQFEcvwTZ5a2WOMw6Shs+gwhvS2rzgVSgH9MUkxt5kQ6X8?=
 =?us-ascii?Q?cKB5rwGoGL/Od01h2woZhbC5ajw0sFSVXojphA7p+wFyGWJ/R+HG/sxke3nU?=
 =?us-ascii?Q?gXmha6GzRbzUFDEfWR7ZLpSJ48DkTiiXtyL3Nl9YEXpvdDhDL6SH/tOFkTj9?=
 =?us-ascii?Q?NV6eofraKK5cXeHvasMC0iqvfovNwod4DEYD2sk0cKn43wzEkkdNEHP+yRJO?=
 =?us-ascii?Q?mbFvmWKk2hZUZnkDIjCsRWYgVaBDWwI5xn9fezoyCuY78Q0dYoycubyDK281?=
 =?us-ascii?Q?kC0W3LDjncxo8ejg9QXcJKU8qyRTjV3s8iMLwqFabCOwLtjTh5eEDFcG6poU?=
 =?us-ascii?Q?L/o/vt8KW7FwXdDcYaZBIiMlsFG+dlQTM9P8lyjFjNOmpSnZFHN2IbE/pTTM?=
 =?us-ascii?Q?P5Ro7HopvN+88VzV89hf79aeodCobGAWofs7D5/tXoYkn+YhSYmJpoimi8qS?=
 =?us-ascii?Q?e/znFZzDPSS/URPMj8HfGAxTPC6ThmlC0CnklZiJGPY1DjhTGDK/Le24rT6h?=
 =?us-ascii?Q?svkLdhzaddStekcGKbmNtMQTYu1BcW9RrHKbpRc0+rhS/iYLBFtFovZdVORt?=
 =?us-ascii?Q?Jv3s0SPWfcFg8zWRldkQFnfcoTizCqinL7z0tTQ/PG2Gdy6mNuqqik19f+r1?=
 =?us-ascii?Q?SOe3lsV8WObLWl0iarW6A+PXWgahQlBa9Neh24AP19ph5hrcAt62MRTOmipB?=
 =?us-ascii?Q?xTGCfCIvwPko/3FXJVlmD/T72xJ6353Z7uyusqygqe/K63y2jSKjOvTdZJi7?=
 =?us-ascii?Q?KRV5sUZ1tkp5tKHOBo5Gw0xS0wSoezXiCPhZQfKgvzb6CIu0MaqeAMsfHrUh?=
 =?us-ascii?Q?BmK4Q2/djB5+SHpgSD8NbbWc1+I0lLU0apMY4bIiZhvhsec=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4789cb-af07-4719-7fba-08d8c3edecd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 00:36:31.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tj2bJo97Gva9oa3DZax1PgVAmwwAqYtH7n2SZ2r1qbiI6tJvCeJMe00bMremanyXnWt7vXhAf2dIArN+WeNd06QNGGM5t4uUUdOSxmGwvUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1019
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Tuesday, Janu=
ary 26, 2021 3:57 AM
>=20
> Restrict the protocol version(s) that will be negotiated with the host
> to be 5.2 or greater if the guest is running isolated.  This reduces the
> footprint of the code that will be exercised by Confidential VMs and
> hence the exposure to bugs and vulnerabilities.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/connection.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 11170d9a2e1a5..bcf4d7def6838 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -66,6 +66,13 @@ module_param(max_version, uint, S_IRUGO);
>  MODULE_PARM_DESC(max_version,
>  		 "Maximal VMBus protocol version which can be negotiated");
>=20
> +static bool vmbus_is_valid_version(u32 version)
> +{
> +	if (hv_is_isolation_supported())
> +		return version >=3D VERSION_WIN10_V5_2;
> +	return true;
> +}
> +
>  int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 v=
ersion)
>  {
>  	int ret =3D 0;
> @@ -233,6 +240,12 @@ int vmbus_connect(void)
>  			goto cleanup;
>=20
>  		version =3D vmbus_versions[i];
> +
> +		if (!vmbus_is_valid_version(version)) {

Outputting a message in this case could be useful.  The message should show
what version was negotiated and then deemed invalid.=20

> +			ret =3D -EINVAL;
> +			goto cleanup;
> +		}
> +
>  		if (version > max_version)
>  			continue;
>=20
> --
> 2.25.1

