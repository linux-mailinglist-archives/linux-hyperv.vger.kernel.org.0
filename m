Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 157E11FFB14
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Jun 2020 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbgFRScj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Jun 2020 14:32:39 -0400
Received: from mail-eopbgr700132.outbound.protection.outlook.com ([40.107.70.132]:53089
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728230AbgFRScj (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Jun 2020 14:32:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btIhQUO8Q+1XnBywgC23o8sNu0taiEmLAn/aSQKhf4ZlQ4gAiIb+TnaDPubpBqYjWhtOBzOexOFKO4aGO1b+ItUiBrUxpikqTKBZ2NzUn03EoGpBaDygfa3QDYBuV9S7x1l6sLfkipuztWEX4maUkX9ZP1bRi42M+Ou/ER5tqyC8qIAXiwS0oh93Bc3qO+KRKGaHHM7Rfr+KyqFYNVZyn5VWetRR7PULsmaXgcKvuFSyNDH5Z0YfRpdSU1ioQCeCzsJ8ZNRViyau/PKGLIwkKLtBFwcJ8d432WwKfYuuoozqxm63/gatwjqszobsl7bDrQjrWJkZu9gVGjcdiup0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeuL+zJ8uFlLrVw1Fa3TpIv1mNe+8w3CV53c7xjgbA8=;
 b=YYHxblJP/zQoLWFo4fU7Oz8g4cE+Xi1zdILcf2il2gQte+JVN0idduomOT+VBAgooEL4LQ7QHTLJp6yUAr3GeRTOXtiv7AxvzioeHahwkHApGDaWIFu1yyRtJWop/Zu9Wty1peP3tTh5/t7lLLnonanifNIrGCeR77PVUH5QyP6jviOrkARkTk42cSEVWy+2WVIOFtB803QOCXM/TqfCysXYCiF8NsD6FJMHhhJ3uF8csnwoZE8SwbNKMWoPlupLS1c7nh0s7bSBqILrvWpuknVL52w97++huEXG2JWCQ7xLN5jPlUmpXLhtJsVAU3TQCQp9p7mNjfi2LmIn8DBgwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeuL+zJ8uFlLrVw1Fa3TpIv1mNe+8w3CV53c7xjgbA8=;
 b=K2P6nRQLP5y7ALKmT0orX2e9nuH3lbYQF8BoUqPTnneTI015gb7Tyf3Clk9YUpNRhWVd5OOkBK9gsRytmERgkYcMJH/wJjs4lAxs8QW4oWPEk3vIKjvRHKCXtYW5x8ndVq9oBG6DcNm0mZGZpB0lH5uEWGCX0mTJuFL9YwsVKeo=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR21MB1781.namprd21.prod.outlook.com (2603:10b6:4:9e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.9; Thu, 18 Jun
 2020 18:32:37 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::9583:a05a:e040:2923%7]) with mapi id 15.20.3131.008; Thu, 18 Jun 2020
 18:32:36 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 6/8] Drivers: hv: vmbus: Remove unnecessary channel->lock
 critical sections (sc_list updaters)
Thread-Topic: [PATCH 6/8] Drivers: hv: vmbus: Remove unnecessary channel->lock
 critical sections (sc_list updaters)
Thread-Index: AQHWRMcSkHo30a6xC0+ZcdM3SAEVHqjes8FQ
Date:   Thu, 18 Jun 2020 18:32:36 +0000
Message-ID: <DM5PR2101MB104704A675F4EF0B52D97B58D79B0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200617164642.37393-1-parri.andrea@gmail.com>
 <20200617164642.37393-7-parri.andrea@gmail.com>
In-Reply-To: <20200617164642.37393-7-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-06-18T18:32:35Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a0146b20-bbb7-4d56-8d83-b82021a046f8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0aca69a1-84c4-495c-9ca3-08d813b5f990
x-ms-traffictypediagnostic: DM5PR21MB1781:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB1781BE335B1E7A98EA77C6EBD79B0@DM5PR21MB1781.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1051;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPjEKQf4/wgLA1de5iPg3zj0Xg1mym6PcE2I0e7mpuuRstSiAN3weLpEhfveZaFqOKmI7a8xoVBFIOZRtvNPZfl325eqIGf3dbWdiX5S2DBt74AAO+QcWOYLsP1FZ01Lb7yZMOqfTPk0RiSt/7HgtgDkbViTaj9VpUJbM2+HOqHUSEIpcbJXeEaCp6Kkq1FmcqNShWJOH6+4VLacWmsyGbkwAMhu7pyWveEnH0fmRhTD0xrwS1Sp4yy3Ag1HEh3VgUPL2pqyRJuItYohaLMpXpt5gJ4/La1HdNrOMeYAf0FOdp7U8PJQT/g5Irz2I3Xgr3hocUQvrrwuDpgmaQ2hkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(5660300002)(26005)(6506007)(52536014)(86362001)(10290500003)(8936002)(4744005)(316002)(15650500001)(7696005)(186003)(110136005)(54906003)(2906002)(33656002)(8990500004)(4326008)(478600001)(71200400001)(82960400001)(64756008)(82950400001)(66476007)(9686003)(8676002)(66946007)(66556008)(66446008)(55016002)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: NaYDfc9sy2WLWX4Hka1yNZ3Hw1DuZXJzKEI/N+rjGLoWANdI5MxThkP/VFNuXrQKPZyH4rOBtF9+9IABc6PVi/5jsUu1GwS7MQN0TcL3Ey51VXBc4JjP5i5Rb/fFIKryzYzecDGTKF0J21BzgIJoNEB8hKYQCgt4kRdFAhZoLydJXbAqz0yBjUmEZeQt706br6rKp6lzyMm+xdwyoGctc1R/N8n+n7GkeEFiNV7//hi4qS6VID7sAGoN8PpHJ4Ahfx1TtjkX6q1XLodWo4tM3v5Uz3BePWnNbcISIntQKBAcwGgDYZYFfQUigBI19LC8MHZ0jukwYNsakbkiboBILOFrFDd3Ud8KAS7kl+qtHTCuxleToKA/Ww/t1JCz/Xvv8Hwwh1igM/hLoYZNnyEBE+XtozaPSNcjQB5r/30iYcP+UDYeZPcHQjgVEf8W3FhjIYxWiKh5YOmwx7VBknEq++CH/7bCLrPDfEIxJvmUFeQAe+7ltjFr1pZofv5wQK+Z
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR2101MB1047.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aca69a1-84c4-495c-9ca3-08d813b5f990
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 18:32:36.8919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eQOyZe0Ydqik2r33bsI3eE8A8JpDV8b/DBd0/2x9TOTv/W/5DmvaIaDT7JA7ClCwFWV+RC+FInP/6f4Eku3wWTymHVE0Jp1DxbNMgoR/yVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB1781
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com>  Sent: Wednesday, J=
une 17, 2020 9:47 AM
>=20
> None of the readers/updaters of sc_list rely on channel->lock for
> synchronization.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
