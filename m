Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B601721C5B
	for <lists+linux-hyperv@lfdr.de>; Mon,  5 Jun 2023 05:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjFEDAY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 4 Jun 2023 23:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232605AbjFEDAX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 4 Jun 2023 23:00:23 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020027.outbound.protection.outlook.com [52.101.128.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D6E3;
        Sun,  4 Jun 2023 20:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBKElQQGN5oG/Owj9pe57jo4C+w1tUtWJdU0Y/1hOUbnPhPsuv1yun8jbAf+G9d1MCJGFCKoLp5e0KYBA0GT3UP5rDVOP4n+8pyvsfDgZZifg5KAafwJo+jKXrzIN7Detuwt196hTtHvmtPYqQ7PIyn1CK2VFAoFe8dgStEiEIFKPpUDnEtjHPlH0zTYrmsXTT+m+hpDPCa9RANpoeZaZg9nHJKOiOCnaP4JGSEmsfXXVCtrM+wZDFSO2yUnmnOSVJGqaKWCU1EUgqC6l8+yV/XEJAcQaO90IDDKg+xU3NOIKa2YQVRWi0Qaz9epHhcaobl5W/1r2MpoxCrNz1wEgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w84fpol/8YxFdApq44wJVZ2mhkzTnwY596KnZeAkXN8=;
 b=Kr/QHNFDNoZ3T3Tc16vxJ03FIBc1OKUMce3CnjHDdeSXVX8q5JjzejtIo/I3GEICxH5Iu+U3e9QsnNKTNIeA1omab/Rs7yd5T4ipsjwRxkGYzARgm7XdmM9KscELpZj2Hjk/ygg9vwb/NTPuwMTzv/v+kAWVB4u799RQhKRCN59EKnvNiqmdFMYxhNmvIKINzMJjUGjehtw3ABxoAM0fusx2Gr/aSxr8B4/JbFoWDFPJzQ1NeRguJ3/BeWh/XskCGvfLzgmlzg6I7Gse8L73VTrBBMtUHFur37GJcH0N2+mZmAo2KDR7WXWWV1JdBm2AjIDbMjfWox9f9HAME1lYAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w84fpol/8YxFdApq44wJVZ2mhkzTnwY596KnZeAkXN8=;
 b=DhX3+nJnOzq3RThEBi7mQ6FvxlqjTGpZ0UTKTXO6bgFMIpgl/AU6GVvYPEo3Gc5ujBU1coETfALbrs+InnSQ1upLjjTT/mDPE7Yf856m06QoNHFUA9gd08VcaNJtw7gWgxBfxcT+Xh7km343FC8jwdQihz5ehFPLbu9gQd5GtCA=
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e6::8) by
 SG2P153MB0378.APCP153.PROD.OUTLOOK.COM (2603:1096:0:8::7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.6; Mon, 5 Jun 2023 03:00:15 +0000
Received: from PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11]) by PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
 ([fe80::1cc2:aa38:1d02:9a11%2]) with mapi id 15.20.6500.004; Mon, 5 Jun 2023
 03:00:15 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Saurabh Sengar <ssengar@linux.microsoft.com>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH 1/5] uio: Add hv_vmbus_client driver
Thread-Topic: [EXTERNAL] Re: [PATCH 1/5] uio: Add hv_vmbus_client driver
Thread-Index: AQHZlrOaQXWNO7c7CkSJk8CLIVQB+q97c6pg
Date:   Mon, 5 Jun 2023 03:00:15 +0000
Message-ID: <PUZP153MB0749F19E7A3DC1C2DCBF16ABBE4DA@PUZP153MB0749.APCP153.PROD.OUTLOOK.COM>
References: <1685692629-31351-1-git-send-email-ssengar@linux.microsoft.com>
 <1685692629-31351-2-git-send-email-ssengar@linux.microsoft.com>
 <2023060421-unclothed-hungry-cb3e@gregkh>
In-Reply-To: <2023060421-unclothed-hungry-cb3e@gregkh>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=970ffd8e-e486-4846-8dac-0ffd0da76b33;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-05T01:53:32Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0749:EE_|SG2P153MB0378:EE_
x-ms-office365-filtering-correlation-id: 78184e62-bb71-45c3-4f68-08db6570fc97
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZDQi1+YgDX1BSP0qWutgSWy31meaiPJW2N9vs9OLuBp7TdSyixyM1guVBAlhO4pKxyyHeAx/1dasibS7KCJhos83lL/VSwaLNIanndXvyC0lTSybWyVhqLCwWIkgEygfD7MLEcEnIgIUK6eHZW3R1356QrjKxlfhfXP2xtXr+tzrQchIcXz9JsHTagWar6irmQ8F/mgaDPnteYqRdjBXnkSJS57LzuasRPAp53z5+Do+c/vkKC426VDnp91096jf2cbJK/2Tg+eOet7UzVH+984KOBxoDNGhAXqe9SwsMS3XfKbrooiKkQXGmmBsSKR456Oa4P+Myn/XwFFjcUo6Bp6phBta3Ej87EFxLzuR1YHp01IeRTr7dpg1bBdkyQ5xfMxOpQ4lhbOusjNwlofIkR27LtQVyIVjbEVn/2Rc2h54ruRb5DVqvdG2GfhKJbZPTp1bEJFgnTJPIfi5HluAZz2V/Aj/sNvLd5VYuZTubBhuRiN0XOKOIpAkI/nJ3DA1CN5O6hzQOWUjKRY27CLjporg5QC/BW+Y/l9swh8NaImLokq+ldk77XTrzjeHtGhaRSYWzHA9tGLoPX3pJtOt5+9CJhFFrozYUHVaVROrE1VMDzeNGCj3Cj01Khp8dajfSBIru6QAILgUtqhtRNbTcc8HMh+IauLLuaxoqqf+Bw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0749.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(346002)(396003)(451199021)(53546011)(6506007)(9686003)(186003)(8990500004)(83380400001)(71200400001)(7696005)(2906002)(8676002)(8936002)(82960400001)(82950400001)(110136005)(54906003)(10290500003)(55016003)(478600001)(33656002)(4326008)(5660300002)(38100700002)(64756008)(86362001)(122000001)(52536014)(316002)(41300700001)(38070700005)(66476007)(66556008)(76116006)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i4qEM/fDjpjpEuyYneatoswGc+kZ7AGNTfBDUZk2NASaJ4lYdRydPMWlZgRO?=
 =?us-ascii?Q?JFLj4g7AHGocKaJeDYdSLEfuevmIyEffKt4i4CLyAJHhuXKHwUprMGnBI90n?=
 =?us-ascii?Q?6Fp3RsYb8XGrEzIvCqb4XPy+CTjPl1DkzAbe4MAegSt9k3I/I7Ic25Evu+jD?=
 =?us-ascii?Q?TCI/+dqHj5pmQdtocAVozuQoVNtKREAh80bbAPAzxLsLqhfi25pLx1f1FYQh?=
 =?us-ascii?Q?0tep1YELSkS+zb5GQjSJ3xqWxYo64kAsBFF1bsR87mCtTBsefVPqZwC/cuMt?=
 =?us-ascii?Q?7Dv2yZVJwA2rIp4e3Yl1pmv0f/nFVizO4MkFBOUb3Y7pO8lTJFkJtuFCUsJ6?=
 =?us-ascii?Q?Ch1WrYJt8sF331ca7gmuuqzyO0sQ7eopsmNGTuuS1KuL1UXqLhqVq6md3rl/?=
 =?us-ascii?Q?vQHiATrXaIM9yGl2mcIjWhXgwi701xFjOpaIk8q1XxCRD0maieMPazUGXn7z?=
 =?us-ascii?Q?kO9HrEllUc8rgVje3oDABg17iCDuhbm47wPzi+XjzMgORk9B7toksglqeDkl?=
 =?us-ascii?Q?zCJGpHng5hVVeCSaEC/p+VbgmHi9L1HstavsQr/5W3zczb4l3mjWpk29JrFp?=
 =?us-ascii?Q?xVedsqok4bYiitiTZnHgJs2tAmQ6CP+FDuuvNi/aw7yTdJ4GUnMp2ZWun8TV?=
 =?us-ascii?Q?3lZAEhzyMaI0lx+5BzueSFqLbgmi2aDfqkkWY9am+wK1/s4ilpap6nOEoObD?=
 =?us-ascii?Q?vlU1HR3UqvHi8rdzW4R/2UnC7BeB9ZO6S38MOPJY4KL24AgQ+Dly4lfHaqdv?=
 =?us-ascii?Q?25s3GY1Ij+awl8EsaaV56d0oDfQc0NS49CiThxDPmk+ErOJywNvP1pUkvUT1?=
 =?us-ascii?Q?RpV0LLujRGDOkNCx42YnpF3yjGMFpqjbCT+gAhN1yKezWahlnp/yHrdx5kwu?=
 =?us-ascii?Q?Rz8VqN5vCA8H9z9UgrY66FBQMpMUJGsWqhkSDb2SfNxMqyglQqN6Hz/rh62V?=
 =?us-ascii?Q?ziyvXkm+nCsWY0fl7mp7Tx9CoQ4WBCpkJxd9aj1xAMQg00GkjCKnvTXrsRcX?=
 =?us-ascii?Q?kclBpZ71blullr5dJTkP3JHJ08ggSrsxyhd7B2hL5OAD9iDFdlYj2QN+Qejy?=
 =?us-ascii?Q?xVWHcFi8KCcqiej5Tbn2NB7EdgNL63H/UuFyrvJKeIBRVVMzi2k4G3gSs/YS?=
 =?us-ascii?Q?QCMkEF4G1c3yzp8pRdtBHsGS8L6542x5YpUgE8KDoZBpCCigN5HsxghVgq4M?=
 =?us-ascii?Q?+9NGxcL9sTEUCwMyDIflTNqGAhFfgepiiven4VbwNV78dH3ju2XKSmqEFb3T?=
 =?us-ascii?Q?leQXR9lwtF4ixXcOA1QGVk0q70dNBlKrBKxWWslsyCjpRhmLelhKxOkWXxG0?=
 =?us-ascii?Q?4V7kskmRfarb70kKgGJGED3mbC3m2QAZgP2smotmqY//62DnRFUHSx1Ik6uM?=
 =?us-ascii?Q?S49GR7wQoIsbh/dNNpmQ1Gw0gGCyVGnybqg/ocZGqWJWm2HDpbEb7CkDB8/G?=
 =?us-ascii?Q?CzkxcBx2GCKApFiopI5o7gtdA2ig6W19UAHlY//nodpKkKYTHqUgJCaOM9jh?=
 =?us-ascii?Q?epLDGuHp2uP+1Jm2MNte9euQ5cHiAQKRNtwtCunjgpGiFpDFkLRSjeUsBRV8?=
 =?us-ascii?Q?zBvwET3bgMb7236RDHnZOeTc9WqfZHLho0oL9YQx?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0749.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 78184e62-bb71-45c3-4f68-08db6570fc97
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 03:00:15.1494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+eMhoViTxQtJLvGNtT2ODKHXC/VCxzl6tHMuGKY3toa+GBotQn+18nmQbtue2fe3xCRfg9lkhBkfPIZUWO0qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2P153MB0378
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Sunday, June 4, 2023 12:40 PM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; Michael Kelley (LINUX) <mikelley@microsoft.com>;
> linux-kernel@vger.kernel.org; linux-hyperv@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH 1/5] uio: Add hv_vmbus_client driver
>=20
> On Fri, Jun 02, 2023 at 12:57:05AM -0700, Saurabh Sengar wrote:
> > + * Since the driver does not declare any device ids, you must
> > + allocate
> > + * id and bind the device to the driver yourself.  For example:
> > + * driverctl -b vmbus set-override <dev uuid> uio_hv_vmbus_client
>=20
> Shouldn't this be documented somewhere?

I will update it in Documentation/driver-api/uio-howto.rst.

> =09
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/uio_driver.h>
> > +#include <linux/hyperv.h>
> > +#include <linux/vmalloc.h>
> > +#include <linux/sysfs.h>
> > +
> > +#define DRIVER_VERSION	"0.0.1"
>=20
> Why this number?  Why not "1"?
>=20
> The whole "driver version" thing doesn't really make sense here, we shoul=
d
> just drop it from the uio later, right?

will remove in V2.

>=20
> > +#define DRIVER_AUTHOR	"Saurabh Sengar <ssengar@microsoft.com>"
> > +#define DRIVER_DESC	"Generic UIO driver for low speed VMBus
> devices"
> > +
> > +#define DEFAULT_HV_RING_SIZE	VMBUS_RING_SIZE(3 *
> HV_HYP_PAGE_SIZE)
> > +static int ring_size =3D DEFAULT_HV_RING_SIZE;
> > +
> > +struct uio_hv_vmbus_dev {
> > +	struct uio_info info;
> > +	struct hv_device *device;
> > +	atomic_t refcnt;
>=20
> Why is this refcnt needed?
>=20
> Have you seen the other threads about how attempting to block multiple
> opens in UIO drivers really does not work at all?  Please drop all of tha=
t logic,
> it is not correct.
>=20

Will remove.

>=20
> > +static ssize_t ring_size_show(struct device *dev, struct device_attrib=
ute
> *attr,
> > +			      char *buf)
> > +{
> > +	return scnprintf(buf, PAGE_SIZE, "%d\n", ring_size);
>=20
> Did you use checkpatch?
>=20
> It should have said to use sysfs_emit(), right?

Yes, I am using  "--strict" switch for checkpatch.pl, still didn't get this=
 warning.
However, I will use sysfs_emit() in V2.

>=20
> > +	ret =3D sysfs_create_file(&dev->device.kobj,
> > +&dev_attr_ring_size.attr);
>=20
> If you ever have to use a sysfs_* call in a driver, that's a huge hint so=
mething
> is wrong.  Please fix this to not race with userspace and loose.

Thanks for pointing this out, will look into this.

>=20
> > +	if (ret)
> > +		dev_notice(&dev->device, "sysfs create ring size file failed;
> > +%d\n", ret);
>=20
> Why not just use dev_err() for this and other errors?  Why "notice"?

Will fix.

>=20
> > +MODULE_VERSION(DRIVER_VERSION);
>=20
> This means nothing, please drop.

OK.

Thanks for review.
- Saurabh

>=20
> thanks,
>=20
> greg k-h
