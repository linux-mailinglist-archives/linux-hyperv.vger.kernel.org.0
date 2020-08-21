Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706CB24D8FB
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 17:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHUPo1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 11:44:27 -0400
Received: from mail-co1nam11on2130.outbound.protection.outlook.com ([40.107.220.130]:59297
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgHUPo1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 11:44:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUJWmgfTaDfOQBf1Rw2v3upQV0mWkp6oPb0+Zs3wkLNM8CchPYgXE6pF8I9kuzoFa8RZpvMmAWEOVh58HfMXt4DpjgyWsl9kWYRZQJiembePqSKn+SKxm0ev3avLqLWpRWHoLeyVSR78ErfA0JDxQur3zB/tv6l0Wt5QHmquYKdiKMb9HlyWQz4pxuordeVAqWwzSLnbMpX+0flgYEdfSLLP+hcvEeo5X1PWePkrI30SWH72BkpXjZ99jlUGGHIrKWQKH5Vxf0GrL9vXc4qsbjKZIltfrDd1EffFL0rekthKFlOIvnDpwZHJlKxyZjEYPZlKQPxD87FdqJDOXxBEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgnMrXk8R8SU2yZVliuXUja6M02z1fakshtFFyDG1zU=;
 b=PPLtygOrZ/xnzsYOkcp9YyDCFcGivvXZoujGkvppTmqsWCDBa5Bss93ZfDi6A0UtYqnLsLsuU4njwfsnDo2p5gG+MPp1jFp0GYzxBLh/7PtuAtqE+igyxF3KLzkLS5cD3wPhf3SoPoEHB3gsuwcjSHGnw5qSnc95iYLM2DBjsHRt3Mw/O1c84PaMmDrN5PTQLP+1PLi/eF0A6dZ8anEyB468GTpkXW8TA+KuLBZiRvKWFJr8yyQaIxaEe2FzsJSvMI7NEtmhcP7r0JO/PQ6ZMZ/Ydyxw8UbjJT33S3d5GWXtsleIMfpCmhA/QHyeR3Kb73PVIYTVKNoTsx5aZM0STA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgnMrXk8R8SU2yZVliuXUja6M02z1fakshtFFyDG1zU=;
 b=bH9xdqnsa9A0y8Y3HoRwM61cJqBvoS9RHbl56Xq1zU6qYd94ewnI9Hg3oHkUQ462hrzPuh9zOHorOJ6+Fek/arrCoj8zUF9JgZqH54fCCyvFmLOQZNEkIvZuYGzZtECyWrhrWxv79yvgjcN2Hl4GYaF8dOdnrWdtvoxpz7BkEKI=
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com (2603:10b6:805:6::17)
 by SN4PR2101MB0879.namprd21.prod.outlook.com (2603:10b6:803:51::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.8; Fri, 21 Aug
 2020 15:44:24 +0000
Received: from SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::b8fd:8dac:8dbc:56fb]) by SN6PR2101MB1056.namprd21.prod.outlook.com
 ([fe80::b8fd:8dac:8dbc:56fb%7]) with mapi id 15.20.3326.002; Fri, 21 Aug 2020
 15:44:24 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] hv_utils: return error if host timesysnc update is
 stale
Thread-Topic: [PATCH v2] hv_utils: return error if host timesysnc update is
 stale
Thread-Index: AQHWd89dcs7uBVXqpE2QYZ3YDtkCpKlCs/Lw
Date:   Fri, 21 Aug 2020 15:44:24 +0000
Message-ID: <SN6PR2101MB10564B2EA3BC8082D76C50E6D75B0@SN6PR2101MB1056.namprd21.prod.outlook.com>
References: <20200821152523.99364-1-viremana@linux.microsoft.com>
In-Reply-To: <20200821152523.99364-1-viremana@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-08-21T15:44:22Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8768dea6-4873-4844-b02e-a6973a27b858;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: linux.microsoft.com; dkim=none (message not signed)
 header.d=none;linux.microsoft.com; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 987bb11b-6096-47e0-32f4-08d845e91469
x-ms-traffictypediagnostic: SN4PR2101MB0879:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR2101MB08796BC65CC175507DD41214D75B0@SN4PR2101MB0879.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2tIJtEE2yFiUaPvB6pk6JWUY9ola58ugvPEjc/cdZGuP0iMoq1vnIQXWpQxbiRcaX19hbZRcjm6AbHIQ09rGBT7/XIYd4mrks2DRVZClxjjMjarrp2ivr0nKpdi+DvZnCDjbVtrvKwpyYOcRIxUBrbJXugdWYO6DsbCLzZxFQOKMd8OhUrQbGcVeJtMupy7eg+n6j8pOdVjzfQXM0Xt52Qw4xCDUXGHmP+qGpZUNISr+8MHtc10YzusksCXlwceIZdplSvzDDpYUkMiTk/1E0NErDCIFgmB/oVHilA4fgNa5iYWDc3pjL/8TqUr6AH0hDy6rOBUC0HsqoKcPzBlEYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR2101MB1056.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(110136005)(7696005)(316002)(478600001)(5660300002)(8676002)(8936002)(4744005)(15650500001)(71200400001)(54906003)(6506007)(86362001)(52536014)(55016002)(186003)(66446008)(82950400001)(83380400001)(64756008)(2906002)(33656002)(4326008)(9686003)(26005)(82960400001)(10290500003)(66946007)(66556008)(66476007)(8990500004)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: UGfN2ok+xy0GS/aMpC9SwZ2gohwV006wZX8dFx1Nz1jG0WB1HfNZrdYVha+kkdrdfiEQthlc5sGkZKDq32G3lPCEGh26nwhgQIcXUc19RfW30UkS6JKZTwTrjGGr4jNsDfQGKPHRN44BhJlvD/Mxz411I8B7a9rrGTijYH1CcuSQIeM67bv86vdlSi1ZapKT9TwbDGba2Ug2fUfj2SKL2n8sPFnOOSTdbHFTBCJyISg58Eo9wFLLrdYyefwNL1LJrP/pFXbtqpOsn5PfKzRFdAB1Tg5aKZCz4sPAy+TMOeSCWqe3LLC5tlizZDUHkzlMX+0XMZLYuq7PI4Tl+UAQaxF4/sLizPWIlPn010aqVIjCGapG9zCMKbDjw+voCNPy85/2wB08iyqzZETrEI0j5Uo/g3F0z+C8Mq5kvYV0DZWlGJRbUQHW2npaNN0rJAo1oaoC//oHLPIo0Zf1UCwQKaogDbt843ARRmKy6bXKxNhMjNxLDRl/dYxFur05Hw23GCfgU16xuz8ol3GT1VdGvL8m6Nsga/1NmIa9wWe/nhQMHcDKuGDljb+8l4j2fYkX5oCChdzEQ1MKmaRE9/PQxJIgYW3lFMEXAMPTXwa/2eBRakuYH0fIldx/9YQmorhMxgipJUZ4DlbzEGzNaNsvdQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR2101MB1056.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987bb11b-6096-47e0-32f4-08d845e91469
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2020 15:44:24.4330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhOIBrltBTsURZaZlD2ojmoiKNrZhIrXH4BMZUsA2JzU/1DiFG3OT+XNeax2NXEH2WPF4KW3iv4xPcH5NqcuMOqJVUu54tQv8PIOchNnuM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR2101MB0879
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: viremana@linux.microsoft.com Sent: Friday, August 21, 2020 8:25 AM
>=20
> If for any reason, host timesync messages were not processed by
> the guest, hv_ptp_gettime() returns a stale value and the
> caller (clock_gettime, PTP ioctl etc) has no means to know this
> now. Return an error so that the caller knows about this.
>=20
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>=20
>  v2:
>     - Fix warnings reported by Kernel test robot <lkp@intel.com>
>     - s/pr_warn/pr_warn_once/
>=20
> ---
>  drivers/hv/hv_util.c | 46 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
