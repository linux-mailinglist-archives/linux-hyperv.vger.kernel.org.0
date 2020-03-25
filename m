Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 056C1193081
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Mar 2020 19:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgCYSgc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Mar 2020 14:36:32 -0400
Received: from mail-bn7nam10on2136.outbound.protection.outlook.com ([40.107.92.136]:1216
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727129AbgCYSgb (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Mar 2020 14:36:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcI4qrWiRlXexWJAhqxGE2fTVNFLeSLwi+rhNwgnni7LDWwmTtagFkblRlObS+uLcDD0LN566UNO89If53H5Fqi4Urp4QZST7WHSs3LNbHcSNvxZXdLThJqw9kOueJjaMWMgV+Sb+H7p9uJtWQPt58QowWMGMOwz0dtQJA697m7y9PqdQCv3/Ma+CxZRJBmcx9vpTupa3urIfCs8Om0DfOnXf23bWahtjF883g5tDR9KPN1ZG0Q+9wYutwT+m54xk1EjGIH+UkUhB9yKob8Z/xvbCjLIE9l7aJd1/x6hBdePTbC14rQEG212OVOojNq3zjP2Z6bK6U+j6GA0fqLawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dv0nqc4XZmPdpO/MYhePmGzOmulFY9821am2laK3Bc=;
 b=nH3wgWFODn166HFIuyn6x4iVk7mIUkSP93/I3RLLv19tx0YXk9cpRbSU0NK5ry4+95kXO1u6t3AwNDwRU3fuxtiuR+6n9dL/WaPkKrXo0+ZFV1tkKU1O1s7R+Yk0/2Y3ksozSctLmRY83I6W8EG8qrlq685+NiNvkqox4AaScukOVqDXIoozLlH6jxbvsllVQ98XYT8XCc4sfFdBoYVjfWZipB4XL/zRWlSZpmKiRCWvFUPJVRfwmONuMbX088uS7Iw19tFcmXE4Ry9WJnHN9Y9Yeqi8zBOg96iN+0gLxlPnJrtr5gpBJTFEMs4VEOFR8rk6vS9V1Yxp1tyFyDff/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Dv0nqc4XZmPdpO/MYhePmGzOmulFY9821am2laK3Bc=;
 b=W3EUKdwUWINU59gXntM1Nlw1bBCJnzDtpF5kZrRjqzzEH8urAsTbQxy5+M/z7xZtP7egGfSxSj6dvdyWQtMbqcg7PQg07yVzrhW1an/0FN3EK2OGuTag4hegQ90J+aYeZSpu42SnA9XTDBYdz/HMBMRYYYhKNm6u+9admN5wqXU=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.2; Wed, 25 Mar
 2020 18:36:28 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%8]) with mapi id 15.20.2878.007; Wed, 25 Mar 2020
 18:36:28 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "ltykernel@gmail.com" <ltykernel@gmail.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <liuwe@microsoft.com>
CC:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH V3 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Thread-Topic: [PATCH V3 6/6] x86/Hyper-V: Report crash data in die() when
 panic_on_oops is set
Thread-Index: AQHWAbHlE3/XLPZl30CkWCL0+2KemqhZpLyA
Date:   Wed, 25 Mar 2020 18:36:28 +0000
Message-ID: <MW2PR2101MB1052C69095FDC8BA12573165D7CE0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
 <20200324075720.9462-7-Tianyu.Lan@microsoft.com>
In-Reply-To: <20200324075720.9462-7-Tianyu.Lan@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-25T18:36:26.9351444Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a887b670-2f3e-40f4-9f9d-b96d7b156150;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a3a0b34e-cf0d-4157-fbbe-08d7d0eb6e9e
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB093896E405009B723FC1A0B7D7CE0@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:473;
x-forefront-prvs: 0353563E2B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(110136005)(66446008)(64756008)(6506007)(8676002)(66946007)(66556008)(66476007)(2906002)(54906003)(33656002)(81156014)(81166006)(26005)(4744005)(8990500004)(10290500003)(186003)(498600001)(55016002)(6636002)(71200400001)(7696005)(76116006)(8936002)(5660300002)(86362001)(4326008)(52536014)(9686003);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WSgqEbs7kN8/quHnuaMQro4iuGmH31qewDgtrwtjro9lwA2FzDw/EF7NCDRXM9C/Cpd8mCJ4hBoccf8xdfO08pENmxIG5K4vauXofFpeDNkCaSiiCNXUqplOfKCzdddMPuLfIxv6wjBZb+/5vPLPb8WOaWn/6bOYetIagZ8q5aUeqUuEFUSiYlnDcA/n7+IwO+BBv8y6vM6weApBbHqOQVszydIE1ffIxHt0NtUM7P/IGIIwrCKv+dqy5n+2dArfKQaBMCzB4JAGB4bjRI5TYi169Ip0ybv3dgcdY5PYpWsKPKoyWZ898Nr3YCtP5r4RMM+CLk1QHNIBLNezhYX6A4jIbbqAOj0RUJfkrMBOyw2s6oeTj38Y4mX9n1xmfNASwyrODnxC50tREV4Osa333ybk81L6H3ZtYbS/ALIylUwwBtUkZDKF6x86EXQg+sS4
x-ms-exchange-antispam-messagedata: WXVbbpLjMZOOpKSCe/pK/SIIWNZVm0kOwgnfnQASYh7/Md2dBorDhApBwX4wwO9O3HqlcdXCGPbdFuB4iCOTJHm8p/WW8or9cJAvXjEMY7/+IOj+5q5DD2zWRy0XG+sKyaHkPI5IZgGvKcB7ftI/ZA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a0b34e-cf0d-4157-fbbe-08d7d0eb6e9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2020 18:36:28.5680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EWUwNGZLHAOmIYRyvWbiFEHivruODKjHdhO8HEcKO2KMrOMm6pr2atfJnfGv6pscZd/JojALRrc57N/MrMUTOc1dF0apX2PX+mC6tuO//bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com> Sent: Tuesday, March 24, 2020 1=
2:57 AM
>=20
> When oops happens with panic_on_oops unset, the oops
> thread is killed by die() and system continues to run.
> In such case, guest should not report crash register
> data to host since system still runs. Fix it.
>=20
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

