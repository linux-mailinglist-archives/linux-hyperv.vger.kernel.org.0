Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383B1460111
	for <lists+linux-hyperv@lfdr.de>; Sat, 27 Nov 2021 20:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhK0TRd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sat, 27 Nov 2021 14:17:33 -0500
Received: from mail-cusazlp17010002.outbound.protection.outlook.com ([40.93.13.2]:11673
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231199AbhK0TPc (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sat, 27 Nov 2021 14:15:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOyhb6vusUI2J8DruywkP6qVAK2clGDcOd5ESfuhrz68EKrRztujNGQ6Ui99CCH8FPSgeZ8kWc56FCw+VDYzMOO0bY1Cd56+CdwBnH5/eeYEI5YthXKGgVBx+d3kcHpUpC3MxaGVEVDaj04EQ8Ne8NGVM5WoybP/80dnMX5rwsEQkl1Pdz14skOMbyM5xqfwHoXIcqczuza320z/lx8BHh7Z27bB4/fbt5Oh8aklcSMbRiL60lB6imYONSJq2gzBHWlft4llWjoG7QtcJTE8cWp9enTufpa+0uccjrJrU2ovebedNmI3/1B1u3rBUO2UXZ5QnUEn/PEf08Mw5PWvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hjmt/8cxcw6gPyHjyoR98oQcJENlSZDk+utB684+6Y=;
 b=k/yfeAFUG3s3UFy/pJ9AUMX9qqOgLL8naorpgm8HMpSDELtWUV0aO24quMq9seFAnBAGGIAcmcys6xnvs9rwc9+3xDjpC2vJsA/XcuKFSnrwVkLk/VFMLMVN+hmuqgH0/P2NF+CjtGPWw3cncWPl5ln+EpqGdgnhyFDC6Gl6WZjPPO7oOwKN3P5FuKKP/hdv3zrDmZiU1a7Av8BAilDorRfI1ao/6/+AWRLPNU7dwLoVPe0wkFf5+Y2cgNC7EH5v6boD5V5/ySkA5ATuzIkYIeiBrUNoTPpekrxjZwQX/ezrZ0Gy2s1NLhXqqvg1CQ7j3TeNulVW1OrWwUq+KWFwVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hjmt/8cxcw6gPyHjyoR98oQcJENlSZDk+utB684+6Y=;
 b=criPkJszgRkTG4jufPTbZjzLBTHfvMH9ROvly9bmMW6w2RyLYKRb4P5N6qKJ0IPwmSWTbZWZtkpIEgBOYLQ6tkSD8+z9AjJgwmz8+BkZwLvOUwKPs1ao7TLkxmxWmNiE0aoh/+1IQz3smkJgmUfOX4+hxhik9/C3WE+OBVEbG5Q=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MWHPR21MB0768.namprd21.prod.outlook.com (2603:10b6:300:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.1; Sat, 27 Nov
 2021 19:12:12 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9401:9c8b:c334:4336]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9401:9c8b:c334:4336%2]) with mapi id 15.20.4755.001; Sat, 27 Nov 2021
 19:12:12 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH] hv: utils: add PTP_1588_CLOCK to Kconfig to fix build
Thread-Topic: [PATCH] hv: utils: add PTP_1588_CLOCK to Kconfig to fix build
Thread-Index: AQHX4m9B3CfDwQpJfESrdTfbqMNKO6wXvV+w
Date:   Sat, 27 Nov 2021 19:12:11 +0000
Message-ID: <MWHPR21MB159387A26F1FF1A77CEB4255D7649@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20211126023316.25184-1-rdunlap@infradead.org>
In-Reply-To: <20211126023316.25184-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2b4403ff-df17-49fd-b712-c7531a7a8657;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-11-27T19:01:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07362f2c-a973-4452-d9dd-08d9b1d9d0f2
x-ms-traffictypediagnostic: MWHPR21MB0768:
x-microsoft-antispam-prvs: <MWHPR21MB0768318DFF4AF4B1A69ECEC7D7649@MWHPR21MB0768.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vZpsT8KG4XhLdGRaxMpjzOENJi0CtaO6u89GvBy4FMfeybbQL1G3iTCLbEWcObi9YdlgThx2VbeWBGuEQWDhF0S1GbeP/kdRj8QhrNldzr22nC/K7qvaWovDO2YQnG2AMdm3yCNvCUz7vUX22kVWpfConhXo/wYAQRjJBWNAzyVKmr6WcBd8rMKHlxgqB3BVSaS9dr9zZfrKbA2G0ox1BuIe9POAGl+Ez/2wTZJPG/zBiN4HQ9JJxAe+XhOlMOfAm7kCpC5U7bRbCk51LXPuhQk+WbQZiWf+MV/ZsW7t1gAeAA1GuyKiYbEGk4Fo1flrhzuyLk6iaVbSMWB0C9VWxkSzpJWoC2SeyjbGt4HfE/YcikE1K7XWzh2FjfUfkpqgjOhBtTQfP+42YokjrtPmIMvBkyuC7FGsZpmGogqKHMzfk3s4DaNDJKKU3l9J/HmMTIj3X7IN6LSSZsjFn9axmH9lCK7tO53snV2vwCf9C2jUA6z1lHdXWUBzrP0x9tSOmhrjSG7axWZHR5buWb95HQ70iSTA5SCtqreF67ngEQbBg7HE6unQjVHo1++cely/gKyebdq2Dz7EKJiLP03u2tvRfgLubuxPdrnxm8CURJiVwGwJ5+hiCPH+h4+4HKbcewmXfPgWMG2Pwt8RJme21UXx5HppoIajvzSs/9+fJGD9gfCfaPzQGjFyNoLeqDTVQMyb82xYKSdRNLPvNFC+Sl52Dt5+KXL8B0fDaLPSlEsZutSgT5BCHAAtxWaxSXBl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(316002)(8936002)(86362001)(7696005)(54906003)(10290500003)(8676002)(26005)(55016003)(110136005)(186003)(2906002)(33656002)(64756008)(4326008)(508600001)(66556008)(66446008)(82950400001)(82960400001)(66476007)(71200400001)(38070700005)(83380400001)(66946007)(5660300002)(76116006)(8990500004)(9686003)(38100700002)(122000001)(84970400001)(52536014)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j7OWD3Q5qUD6gjGF88JG74Z55Uc3wavKCejwtG/fUj8L9M8ETCsuEQq7TzUB?=
 =?us-ascii?Q?LSL2cMrtQGjpLV7ycOMmjaqj5pyuDw3T7mXznp2b/VGvODPc6TEFytR6pHqk?=
 =?us-ascii?Q?w7OJRi7EAGmn6BEiSwEWG1adjCkJrZE3h5rT3UZIZt18CV/co72FEViWPqsq?=
 =?us-ascii?Q?ILfKpMGjHC+FlKz6LNQlm2/e7xyRMvlxO0MHd3F8AljK0JKIkIXZN7LgzBNQ?=
 =?us-ascii?Q?Lxz74CmaVgTzbwsKAlr8GXbW3ub6rnYJrj2BWgi053tYPKf/VdZLqDSInISe?=
 =?us-ascii?Q?t85U7dHRubfQpteaXazP697oZqNUIQIavLeje1YxYJqu0+GpFW7UsotYQBmh?=
 =?us-ascii?Q?XhBd+Jqp8+FBhM4zzPBHrMp4G/HF+f2TLc8ipy5mO1qr8jG6dQqYzD136/V+?=
 =?us-ascii?Q?lQE9vGmh6xFn/uBGpX4IEpV1pN905FnvbWAIeNYGGHV525sczdZyHQbMlU4i?=
 =?us-ascii?Q?pIfgZujhN2oM91ggFGxmUIK/AhbdiWha/hqka/kXRFNodIQJHpMbJ+oY3Yhh?=
 =?us-ascii?Q?BizIzKH19Qa8N0O06Hdd7eh7PdAL46nPbPyJCD1WDHM2tRU1iXAhQDTqnMaE?=
 =?us-ascii?Q?I58t6fNYZIwlkWJw62mE97NyvfgPCO39tXmQt9Z6LIp/x6/h1sjq4+H5vy3z?=
 =?us-ascii?Q?LHucP2UMwuhwnzxA8r5LVix2/+XyIQd0HUIhir57zT5DQtXiuJEKEHG751g+?=
 =?us-ascii?Q?FxRo5MNme165FnK5R606oueldkSVuW57P6z8xVJzoiyOSI0OBr0h55gR95hy?=
 =?us-ascii?Q?AxTapsz2gHlqrrhKL3CJ4bxl/LVM1/oV2eOvxpPBP5kFxhr1pQh6vYkWUjve?=
 =?us-ascii?Q?jhsGxQIuaY7Hd5rbJybiuHwOuGe9Zzo08sZZgq/zCteSDTHd7LaUbXaM4diX?=
 =?us-ascii?Q?RfhA/k2g5XO3PXRYe6flqWggapNjFKuvQMnN7q75EfnaHjdinuaFO81o7BIK?=
 =?us-ascii?Q?WACn4LccLsu3H1ZSUXThYBThdYFdkQRvpmeuYFYqQi3psATZzRJlQxg+WvSS?=
 =?us-ascii?Q?U6tHeFfPCJ8TxvHu9T1v/ERulI605fKYTL+R7CR2j9TfYjopI/ySr3lJvmcr?=
 =?us-ascii?Q?Ls5wFXawGLh1XhdZE/ALU45KHQzXRAjuNl2TLk1e234fyvAS+TovGIqc2gTW?=
 =?us-ascii?Q?T+q5CvCtL9l4aXJHQeMtKX1eMhuZgWDnfunG8nchJI9eYRIn+F0TAXtTjffe?=
 =?us-ascii?Q?0NjMZAj8TD/MClkLlHh06Ul5SPAaT/gm2xb2dUI0Xb+YZ6DzkCWVifv6WeVW?=
 =?us-ascii?Q?rU+VxtltOBskCoE3q4P1un8a9qE/33Fzn7nFfG7Po0my/xfmgPHGcC0s801d?=
 =?us-ascii?Q?Nz+Z2cRpzQajKOV9eYHbpf8bdZidR3eSEwiakNTzIVVJnUhPAOBcRWWBIZ/I?=
 =?us-ascii?Q?t2hpGkK+q2MtBklFyq66PDgbWM3DdS4P7V62RjGa7cgmEBZDCDIf8zQEwdK4?=
 =?us-ascii?Q?g938mYWY2feLJMtS+ReEWfHiNBzA83zu0E3OwLzDwbgTzT5IIAWehOzBo22E?=
 =?us-ascii?Q?cZeiXdxn5z9yFZtgKBR0N4Prz+P0FppVtNLH4nlHAoOBYgoB0BdRTIyD8Nko?=
 =?us-ascii?Q?d4lEa9tji2lJLhr6EP6LRFg0G8RgHj31Geczql0ywLNgyJe+XFV0UCu3iKs0?=
 =?us-ascii?Q?56vT5Tl5c/TeayfvL2O/0OCfPZynFcW7GRDZnBLXLdjlvFl7m0UpeyaTgbLU?=
 =?us-ascii?Q?XyljDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07362f2c-a973-4452-d9dd-08d9b1d9d0f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2021 19:12:11.6564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgHh55Rx5avJJNgO1h8ZUGi0fSwCL/P2CyKCu3GFpNN0/BzS+uBrR0ilmgRzNm5WIu6YLb9fySiYX03LIpHkMsqinbOgAjBfpLE+NcEVjBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0768
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org> Sent: Thursday, November 25, 202=
1 6:33 PM
>=20
> The hyperv utilities use PTP clock interfaces and should depend a
> a kconfig symbol such that they will be built as a loadable module or
> builtin so that linker errors do not happen.
>=20
> Prevents these build errors:
>=20
> ld: drivers/hv/hv_util.o: in function `hv_timesync_deinit':
> hv_util.c:(.text+0x37d): undefined reference to `ptp_clock_unregister'
> ld: drivers/hv/hv_util.o: in function `hv_timesync_init':
> hv_util.c:(.text+0x738): undefined reference to `ptp_clock_register'
>=20
> Fixes: 46a971913611a ("Staging: hv: move hyperv code out of staging direc=
tory")

Seems like the "Fixes" tag should reference something a little newer than
when the Hyper-V code was first added.  Either commit 3716a49a81ba
("hv_utils: implement Hyper-V PTP source") or commit e5f31552674e=20
("ethernet: fix PTP_1588_CLOCK dependencies") when
PTP_1588_CLOCK_OPTIONAL was added.

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/hv/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>=20
> --- linux-next-20211125.orig/drivers/hv/Kconfig
> +++ linux-next-20211125/drivers/hv/Kconfig
> @@ -19,6 +19,7 @@ config HYPERV_TIMER
>  config HYPERV_UTILS
>  	tristate "Microsoft Hyper-V Utilities driver"
>  	depends on HYPERV && CONNECTOR && NLS
> +	depends on PTP_1588_CLOCK_OPTIONAL
>  	help
>  	  Select this option to enable the Hyper-V Utilities.
>=20

Modulo the "Fixes" tag comment,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
