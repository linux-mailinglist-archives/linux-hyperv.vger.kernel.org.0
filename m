Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A40430AE5C
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Feb 2021 18:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhBARsg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 Feb 2021 12:48:36 -0500
Received: from mail-dm6nam10on2139.outbound.protection.outlook.com ([40.107.93.139]:12297
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232532AbhBARs1 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 Feb 2021 12:48:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dxu49mUZN+jnuZUFUdYAS603NxTh98ZLXZ3JpkvSpp1UDLbhoRN50Ife8P5UmXd8DeNiN+cgUW2h+STvMiFSaEX2AS+6sRhZlnG+j2v1MJVXLNUT4BW7/ovZxLS33eLc9HaCqlxnrpgYo+8OAx9DE5keVOncRNzOGiIRUIaNt+E9I2q3ZqBaKmRVH7HrAPjZ0aBYv38w+57wvFP/H9H/uLjKGMARF3UWZi05CyuIeVZ6PgAJxXImWylO8bNbCabc0FuX7zOb+mU+Cty1Vb6z5uzWvcNx8KFAj1OakQWY/bGglQeOgEpRL9x33Cc0uxwrtVWoA6+hXWR1DbDrwM4wXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKhuhHx5FD6FoxPfqjowOvsZogQvAeOtgDlUikGrC9Q=;
 b=Qi2jygf8aIh6R9ZOuDxrooqPC12lmpeIJcB7Ws2lWEfXsJ3RzEy8/N6B8FgXk0sUdzy6whwEUJRHehClt8wKubD4nvCytrdJ3N4BzJaMqQCqEfXIkxg165FATdiztbtLbnfgnUX5dOhK+DyWwEpKdVmupa8fu+EMmC4YMwEJKIb0zaYm3+natamkUjMg0brtodWd/+7nJDWMZzldQii2mQiQAacjRDWyNSj8j3MOcX8oQiNT83H2y6BeEJZyPcAsVKqC3hHU5l9L3dMAgsdzRzPfmsBQxYAZXoJYz82hcb9vvXzfv2O0My9ATXonoN7sPT9XTBHFaEEv8ToKouD6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKhuhHx5FD6FoxPfqjowOvsZogQvAeOtgDlUikGrC9Q=;
 b=Bdv9NgGA/JlfKhX3IBqhXkkBB5WfTHIVuU3rkK6B5tIIoqogzI5SIyY6ASnWr+jNvgiGwkJccYxWNk2L1hOx/1v1Xl5W3HmrlSViEvQcgn2QDW/c4H/fEX7dTYqMVl7vBjjjvRmrGAUdofsrRLIyozWOMJMGBTp7SZhQrlQTgG4=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.4; Mon, 1 Feb 2021 17:47:39 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Mon, 1 Feb 2021
 17:47:39 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>
Subject: RE: [PATCH v3 hyperv-next 3/4] Drivers: hv: vmbus: Enforce 'VMBus
 version >= 5.2' on isolated guests
Thread-Topic: [PATCH v3 hyperv-next 3/4] Drivers: hv: vmbus: Enforce 'VMBus
 version >= 5.2' on isolated guests
Thread-Index: AQHW+KlWWg1vu3veF06OPm6Raofm6qpDkx8g
Date:   Mon, 1 Feb 2021 17:47:39 +0000
Message-ID: <MWHPR21MB159313466FBA3DD5DDB3BB54D7B69@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210201144814.2701-1-parri.andrea@gmail.com>
 <20210201144814.2701-4-parri.andrea@gmail.com>
In-Reply-To: <20210201144814.2701-4-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-01T17:47:37Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ba121578-bf39-44ae-a34a-8879ef832fd4;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 18a9f126-5e20-424b-945f-08d8c6d977e4
x-ms-traffictypediagnostic: MW4PR21MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18756BE8D20CD672CC1645BBD7B69@MW4PR21MB1875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BNHirqMD1IZ9qGACz+pRHsyfjMDhRreFsoPywLAWZwRX1xzjfJ9RPAcyWkVAAtr/CB6y3LE1j6Ov4/UJS4i/+bQViqpLZFu27PaflIjrn1/JYqFTlY+K+kMBfO4m9R9zHlZQ3JZEQNkQfvACurDri4QRwdO8usIvDdwU/LfW9pm95hD2sHH5iEq5BddhIkTaDHxnx6E49NB1FjpYGuoH+r8oysDeKGQ918EaPdGtvXulo5CyJzlv5+Oa8KeA+f7mIMfTtQWKk9JV8+ltSWiUiNzZ71iNvtFSGVhpWkx9Wx8XDqntnVgs+OMVTwXxdtXfNr+m9m8qj5sIaVYnmZ5MS+6scpBcsLe9m0LMUJS1GKDqADL/07+X4SzEz0P04P/a5P1Yl+3VuOg8IPqRUvBZWWhgL05mFORGwPqn0B4HX/7uok1aV2FSZ0jQh/yb2F52rDY0PO9ib/+w6Eb1AYM2xqy2uIWLrs6fHCS8yWagF0qkMqHRa+4ZXy7P8wZgKEQTBonuOkCVoyu8jZ+7dCg/Sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(66476007)(66446008)(66556008)(110136005)(107886003)(64756008)(54906003)(66946007)(8936002)(316002)(8676002)(8990500004)(52536014)(2906002)(9686003)(55016002)(86362001)(76116006)(82950400001)(82960400001)(33656002)(26005)(186003)(10290500003)(5660300002)(4326008)(71200400001)(478600001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?58VBbP3KvAUd/wWwXC5iWxsEpUanZ5wtLSUa1D6ugALAAgG1TRguoIxaDRBo?=
 =?us-ascii?Q?YqDwhfFBgtwaGe0ZcKmGwyAQd+E5ombONyBttZ5q1eWvsH54Prmuj0MXc4ve?=
 =?us-ascii?Q?fiKXV4FqFB/HT7bwy4Pm5KwxgcRzUpnB8TmoYHMzUowUOKm4ikBtJj0wGTNb?=
 =?us-ascii?Q?OMylaAuIejHbMJCX3ULW0J/HURvacAMLqkhsZo41XS5c9Sssf1wzVyQnLapL?=
 =?us-ascii?Q?AXdN8UaLh8vqjSsCvz+KxdM1IF5Ex4JCtBep4JFCeMKiVPiWSJIXeO1LntBm?=
 =?us-ascii?Q?QroZDFiP8aG5E1TofDqjQz7ACfHcG2fbDF/ElhDEoCXEIFWC1SVL5o1PMi0I?=
 =?us-ascii?Q?BlDoYVy1vg9pMxco2Rlx0AJqCzwXYM8ZfKbELqq8CADEGVi1Ixzyw5ZouL7B?=
 =?us-ascii?Q?dzgFh9heO1wS+ST8/ZmLQb7l5aw1ePk5HsIhAA3zPwkI4zEFncI3aB7ds/U1?=
 =?us-ascii?Q?AxOlChmhTn3Xk0HfFm+8CSst1S5btJil9p4qmzFz4YQipwBuBu7MpoPy3mFK?=
 =?us-ascii?Q?Ggu/7JPTaRDkltJYTDzcBOVVC3dox9HSbE2TljlwK4h/Ok80uCNbFawlO92z?=
 =?us-ascii?Q?mda0o+0+wd/B8Dkr8j9658O/6uSlgyzVxu0L7KuROKqXWHbwEUTaMsG9Z5KI?=
 =?us-ascii?Q?MhVi9GxGaDKxKbGUKygpa+96DWet4SJcPlLzCT1nY86MYz/a2OMjDhyGhmbh?=
 =?us-ascii?Q?fVz8Qyy5OM1M44anf5Ois9LYFF5oFkdOV/KWGBs431xNhVkX++jXSby6VZ2F?=
 =?us-ascii?Q?/aNw64u4BnEs5zOcNzVXDpniEAq/CDpy00P9N33VvRC/ISl/TNrwQmBjC+82?=
 =?us-ascii?Q?LYUkmhcwgYmlhe0NAoPTfTy5oY3zNAszE+YsBqSOW0qTbUxcqv0NAo8Mpjcq?=
 =?us-ascii?Q?ApM9q9O2nYdgWzT6gRMi5kY5dMDDloct4vt9Jr9/G1TIsWLo3wuTZKJ+C9O8?=
 =?us-ascii?Q?zAiPId6idxHWUhHqpbLyMkTThnDGNupQc7BA95DeqShbLuGGo94K9CnU0Ra1?=
 =?us-ascii?Q?bxbgbrdtVFY5oBFtYuTMPY8tNu0A2TQO55ekgHnxwIdEUwzo19L6+zEuReSO?=
 =?us-ascii?Q?KYLWSxu6vllhw2c8YiyP/7SM6VbhVgbxkZ5FvDJ3epJc4TcjBWJJLFbZNvIs?=
 =?us-ascii?Q?J050pc48Cc7vLw2hkOXaLwsbvHuNTdhrn/W/UPsAzgwt1ysXVpTuzk0XMeo2?=
 =?us-ascii?Q?qmFdqZkiYJ5GMMgYaJrmwYha6qp9VeW+/dEMCl8E1RKAIiXabxKMhBzMtiR5?=
 =?us-ascii?Q?9wKoAtI+3gsJpMGYrlfdFCFsN4WNcjsIL3Vg9csiAtsz2464P7e8+VjSyMBR?=
 =?us-ascii?Q?ySoYv8VS9DxWZ9UquQgeSt9N?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a9f126-5e20-424b-945f-08d8c6d977e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2021 17:47:39.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uzmMuyxM5+3UvM7EkmxVQSxUOXrPmTG1b9pgVThHW1xBOczWE0modB26SSZXp7XU05hBUbmZdmeSQY8tGRfqy6oGlMYJTspNIQFWcyBqtgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Monday, Febru=
ary 1, 2021 6:48 AM
>=20
> Restrict the protocol version(s) that will be negotiated with the host
> to be 5.2 or greater if the guest is running isolated.  This reduces the
> footprint of the code that will be exercised by Confidential VMs and
> hence the exposure to bugs and vulnerabilities.
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/connection.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 11170d9a2e1a5..c83612cddb995 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -244,6 +244,13 @@ int vmbus_connect(void)
>  			break;
>  	}
>=20
> +	if (hv_is_isolation_supported() && version < VERSION_WIN10_V5_2) {
> +		pr_err("Invalid VMBus version %d.%d (expected >=3D %d.%d) from the hos=
t supporting isolation\n",
> +		       version >> 16, version & 0xFFFF, VERSION_WIN10_V5_2 >> 16, VERS=
ION_WIN10_V5_2 & 0xFFFF);
> +		ret =3D -EINVAL;
> +		goto cleanup;
> +	}
> +
>  	vmbus_proto_version =3D version;
>  	pr_info("Vmbus version:%d.%d\n",
>  		version >> 16, version & 0xFFFF);
> --
> 2.25.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

