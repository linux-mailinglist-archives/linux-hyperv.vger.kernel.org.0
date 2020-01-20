Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B096C142122
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jan 2020 01:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgATAv5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 19 Jan 2020 19:51:57 -0500
Received: from mail-dm6nam12on2108.outbound.protection.outlook.com ([40.107.243.108]:4128
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728895AbgATAv4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 19 Jan 2020 19:51:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML/2jv63D4gMv7k5cnScb8F93qLolxpT6xZO+nSXf5zVa1M/HF7GoVCXZbsgsVHwhck4UFLUEYaVEXYsS7t+Pk+kgdyCGnLG3NTv3l8t4cyh4Rtgr/RRw41DC/XtlIEJflDdGjCOuG5fuk6KwSbHrsPmhwIU2DAQiTh1Gz7BLkf0kcVwsMr5Gk6LwlQeY0tXAzm2Q5YevhNU+E0eb/YYgtdDji23w2SFUTcDi2ow30omQMODKO0hC7xCL88T1jTeng9saaq4KIISN4Ihcl+dix0jAmTpxGXxq+4dYQXkHAfODi/4DgIk2SpdMtfgYg33ykgYHj4UygQjPTcMCp9PXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq674197Xa+DHOb5IehZbnbVksByBmoZ0PCdrLYx5Ms=;
 b=L8pJYacD03EpsmaOFf9cOIer8reJhBPdqexs+f8xlJ+tsA3L6wrD1mUcRQLl/U2+WBeWjPp7lbGHVdMTftsY7dWX7Pj/wnFlfbtkplBgH09v+mv9B0dVKINCbgLcHd10uID1pV5RFS2RUs66CIdF34fhKwxf1HIyRVkzpaWjMjM8Ezzn9QDnX7Mby/ZcaEzn/7fJnN7u6Wlq8jlyoppIanfR6+LzWpj1KvFWeLSjz6BtGU4aRTjCPfwhcDAHddpXT9iz8D+wC1THuq6r6lCdU9N3VN7A9xD57vZDg56xYscfOH35QjI70KELEVgLz+fHJ/nZswbNBP8qRqK19v7ywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq674197Xa+DHOb5IehZbnbVksByBmoZ0PCdrLYx5Ms=;
 b=G+lTap7mW5g12rBQ1WUaN7bLsj5D0JxSOdE0BAYXV8VcCtydRNmafTl22lWpdzlPpO9bFYYUMA2dP0/obmXDS34B+yjuak0NiSrR5Vd9NyYEtJdr5S3E/SxH+3WK2272RVbvV9zTc4e2cGnQsmDfBTzy6ENtrFiZkdeCJz10k/g=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (52.132.149.16) by
 MW2PR2101MB0921.namprd21.prod.outlook.com (52.132.152.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.10; Mon, 20 Jan 2020 00:51:51 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::f1bb:c094:cb30:ba1f%6]) with mapi id 15.20.2644.015; Mon, 20 Jan 2020
 00:51:51 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
CC:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Andrea Parri <Andrea.Parri@microsoft.com>,
        Wei Hu <weh@microsoft.com>
Subject: RE: [PATCH v2] Drivers: hv: vmbus: Ignore
 CHANNELMSG_TL_CONNECT_RESULT(23)
Thread-Topic: [PATCH v2] Drivers: hv: vmbus: Ignore
 CHANNELMSG_TL_CONNECT_RESULT(23)
Thread-Index: AQHVzyBa9JqqMDo3p0WOzOxExj3eDqfyuRbQ
Date:   Mon, 20 Jan 2020 00:51:51 +0000
Message-ID: <MW2PR2101MB1052AEC27FF7287F5BA81C91D7320@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <1579476562-125673-1-git-send-email-decui@microsoft.com>
In-Reply-To: <1579476562-125673-1-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-01-20T00:51:49.3159496Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ddd97dd5-38e2-4546-9fa8-2d57891edf37;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 760feef0-0f98-4225-bed8-08d79d42efbd
x-ms-traffictypediagnostic: MW2PR2101MB0921:|MW2PR2101MB0921:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW2PR2101MB0921D6588F399D20EA0AA6DDD7320@MW2PR2101MB0921.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0288CD37D9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(366004)(199004)(189003)(8676002)(76116006)(6636002)(8990500004)(66446008)(2906002)(66946007)(64756008)(66556008)(66476007)(33656002)(71200400001)(478600001)(10290500003)(86362001)(55016002)(9686003)(107886003)(81156014)(52536014)(316002)(81166006)(7696005)(4326008)(5660300002)(110136005)(26005)(6506007)(8936002)(54906003)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0921;H:MW2PR2101MB1052.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3SYD+Ilc2ugQMkCSt8eiJ571ah5vinmP6f8mj+5ox93SYDWlr+uNSwDMViGVsjnnMLoZT/Izpi7WXdr4uF/S5uDtnFMQdsjj74RUNALmGfGYsW6R/iVfykYemtDHbWZwPl9na1R2oF4vKGk3BBxXGVZ0eQyJb+cc/uAi6C0n1OU6JwykCtt5zhqA/qZOHpz4iBkebDXRu+gOM528itcUNBLXPcFqnqfg6fr/Z4vGZDF1oiY5Nu00aljkzeaZiYZ28JwiPmBJTl9Edo/ZDOGim5jezLyOVOuHJjMbQBTcAxe4BZjrdIDdBXr/aW/We+JCk/hlCzK+FeI6e++SA9SEaElb4dNACNunUwiZPS9lAu5e2lKUi4x8OeqHVXvJhhqvJl+01MybLDvgHYXw2P7Msi71b9CnKSp9gjqsaqnKJHWvYraTDRrjseuJEuqb58qI
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760feef0-0f98-4225-bed8-08d79d42efbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2020 00:51:51.0857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXi6bJt2s5u12OK4opcIMeXrKXLu8qY4sYcX11ZQ9zsnbXJ1M0rUoiHQ+n911whKK8KhZnANz+eAPqcygLmOHGmbbkY5hu7FLm1T6leOKEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0921
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Sunday, January 19, 2020 3:29 =
PM
>=20
> When a Linux hv_sock app tries to connect to a Service GUID on which no
> host app is listening, a recent host (RS3+) sends a
> CHANNELMSG_TL_CONNECT_RESULT (23) message to Linux and this triggers such
> a warning:
>=20
> unknown msgtype=3D23
> WARNING: CPU: 2 PID: 0 at drivers/hv/vmbus_drv.c:1031 vmbus_on_msg_dpc
>=20
> Actually Linux can safely ignore the message because the Linux app's
> connect() will time out in 2 seconds: see VSOCK_DEFAULT_CONNECT_TIMEOUT
> and vsock_stream_connect(). We don't bother to make use of the message
> because: 1) it's only supported on recent hosts; 2) a non-trivial effort
> is required to use the message in Linux, but the benefit is small.
>=20
> So, let's not see the warning by silently ignoring the message.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>=20
> In v2 (followed Michael Kelley's suggestions):
>     Removed the redundant code in vmbus_onmessage()
>     Added the new enries into channel_message_table[].
>=20
>  drivers/hv/channel_mgmt.c | 21 +++++++--------------
>  drivers/hv/vmbus_drv.c    |  4 ++++
>  include/linux/hyperv.h    |  2 ++
>  3 files changed, 13 insertions(+), 14 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
