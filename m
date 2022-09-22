Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2615E6FCC
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Sep 2022 00:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiIVWkP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Sep 2022 18:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIVWkO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Sep 2022 18:40:14 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021022.outbound.protection.outlook.com [52.101.62.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFB7832F1;
        Thu, 22 Sep 2022 15:40:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whq/QXCcWTlR4PHwqvTDHcOO529VOD+J6BeVd/DTfYcoUNQrNEc7BMBwAmrN+6lSvATqJJUWV7sflTdVRATcljONtR/DRtw12ZDMJaeGooQkYq8+JvSbahBcKaf7XmdZjmhPQE0/YdXUEbDbN6yXOrooLdRjnGI6HpPLop5mRddbuPTDeETPqCsnNQRRJ3RWv1Ga0QKdFCo6EyX6gLSAuSqTuCOv1lMiq5m1RokK1sD+UpqvoJUdbbBGzWgADRopTbOojdpsA/w1RckupyUq0CBmXByRvZkw5c6K/8+J+slVt+/RaJs/dfUPf+4E9oOafTNWX1ElYOHna7JifhFyhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ot0wUZHJorfB9aNmD64COIq7KsBfk6Durkv3bitSoJA=;
 b=ob2VYY3l4jjrxffnZEuhs3DTMrQANOmpzn6QkbxX4MwybMwUq0pkDNINqZ3Yb2Hq5IwZbacg9l94K79rNJKgF2w6iEyeorDy89TenhsYhQB6HBNzjUHbm5Jkgmset1UKE/zUij5/qvaz7Z5Cor0W02xH6DR8mk50V1umeg7bJSu6oGxebYyK3Uxo0TGMTyHnIaPQFSLr5/KvVBG8GuEECtYhObJsuFz92ge7pSDfn+OneszNbCqyd/ghUN6uLO686hxU4Z2U/JGOV9k4l81bMc0XJouLULRNlzjPgIXfte6/sZG65pgV1rTQeXGVdXpX8N5vA89KH34Bb1xWFApePg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ot0wUZHJorfB9aNmD64COIq7KsBfk6Durkv3bitSoJA=;
 b=UHsGYVwA48vRIOjf0yd8seXq20c/ZkQinEmIqiWDgD1oPXQWmLBuymFdydNje1KEfZKoA2xGOfvUVaDe8LDHKMH0InxkVODEfgvs7BsgWr008raURKxhkW1HrxHMcEfiGa/XCwi+YP38h/z52LOxKCFDEATQZmB07i0fQkIr4Fw=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3657.namprd21.prod.outlook.com (2603:10b6:8:a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.9; Thu, 22 Sep
 2022 22:39:21 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::17f5:70e:721f:df7e%4]) with mapi id 15.20.5676.007; Thu, 22 Sep 2022
 22:39:21 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Easwar Hariharan <eahariha@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hv: Use PCI_VENDOR_ID_MICROSOFT for better
 discoverability
Thread-Topic: [PATCH] hv: Use PCI_VENDOR_ID_MICROSOFT for better
 discoverability
Thread-Index: AQHYzHPeGYBt742ZW0uQo7451Q99LK3sDzPQ
Date:   Thu, 22 Sep 2022 22:39:20 +0000
Message-ID: <BYAPR21MB1688949A28069BABBA50027DD74E9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1663625084-2518-1-git-send-email-eahariha@linux.microsoft.com>
 <1663625084-2518-2-git-send-email-eahariha@linux.microsoft.com>
In-Reply-To: <1663625084-2518-2-git-send-email-eahariha@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f200e420-2c9f-4094-a4eb-1be64c8e6b4e;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-22T22:38:36Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3657:EE_
x-ms-office365-filtering-correlation-id: 695d7258-4670-4bde-b730-08da9ceb4a99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hZh+ehDSmSXb+oz6//xrlc9I2/fw+Zvq0py8ExGxS35JKa5+qDcfwuodL9QcHiCRErY0pBegRjNT+P3f8O+kZFw/DeEbcNz2aZw8FzrC92Jd3Fn7/DkbAZcuErb17XdqMSqrsEvQe47rmvXRgzxMn1NUe73RYANI2oJiMO8zQI4ZGf444uhDFD3Q7Ej1vJZQZ1AY4cGOy2XK6Vb0NckoYjCWWqM031GGhp8ZvZfeB+AqsycKQtg3dH7HQkiG6/2FlU/awf9gyUPcG4tyoLYWeA0H/20qwWluqYv/RxL02Lnj4So2q/D0CqAxs4fzR5rENyp+OyLNg9cgR+9shc5UqfXQCWt/rSWruCdowsnBITYelQUv+g4uRn+pn3BbujbX4jnoOdZENKp0bDPZ7Uq5r9uKa1D7XVBiZyHTe7TPHiD6ZRCpM4MhHeWXzxzWd2Lfxc4fvJCsFHSk1MqqthJ3BbchNgJTIt/9hUex7k65KOaaN1Xa8J9xS8Vw/ksTf/hSMn+Ildf6woiNWb1BvIz0jBkOjRA8VPE82aPBxPFGwus+nJeyLwjRYpDo856KkiVB/Ejmpl0BEEmEwFP32tPjsP1HcWhS64enHxK49jzxN6oiR/DPsAsuhQE4L1DnzE0R/EI59XM2rGfD+XV7Wiprvsw15FhBfa70nzc0YGWdTvU1HSjlsnOciDFyyyvE2U/JQ1HqpmFJyO5Rpji+3llz/oW7I8DP5DRDb1oX56gPCxUBuAwrSmLfOiD0hjHsA2+MLTnIZn57up2z1XzSCJF3tQ8PkYE5uf0AGbNPVxKaopOuTGSBgOyiEffA/pFJBf4a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(346002)(396003)(47530400004)(451199015)(66476007)(110136005)(86362001)(71200400001)(316002)(8676002)(10290500003)(33656002)(5660300002)(66556008)(64756008)(66446008)(52536014)(4744005)(66946007)(76116006)(26005)(9686003)(41300700001)(2906002)(186003)(8990500004)(122000001)(8936002)(6506007)(7696005)(55016003)(83380400001)(38070700005)(478600001)(38100700002)(82950400001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wDRiPXVXQf8/jZG0LydSO8xfgpamhHtdlaZiT+Ef//oxC0f5O3zrOtIUuRck?=
 =?us-ascii?Q?i86Kz3HG9r05Vlu8Vm5FT9Aok76fFJPyCQvlEbj+j8LqURpB8ACl9DtXaQgE?=
 =?us-ascii?Q?1crXxJp3lC2epkGIaOIuFnbe27CybzRYH305Tltkj/uo06mlZgB7IB67PAxI?=
 =?us-ascii?Q?jGN4H9DFNi8r6gg9jZNn0irCmswEDzUpxeG42+3+5vj+fkHaKY4ctkhltNV5?=
 =?us-ascii?Q?giNfLw4cqgQgujCYsgP9wQZWhzsdgxvYphOukaIWORuBMnZIsojrJfuoCGAr?=
 =?us-ascii?Q?G/h/Og4iiWvHdqFbfwZ/XSOhqQhbSgCsdT+YlVhwW6P1abZyPnSBQ/vRSLj/?=
 =?us-ascii?Q?JmQiT9aMG0/jo+VwWRSyswKCjnzpToUWYKzWY0SvA9/a9IteRjIA6xZaCZXN?=
 =?us-ascii?Q?fZAFXR8noWeAotT/wdM3rgBwQ/MsBB443OlK3uGD1Jvhr/2HBT/7iTT+uSms?=
 =?us-ascii?Q?UXWmdF8w2bFxHO576P1ja/ickTu8egmJkDXKzBi1Ygqrkc15F1hLQ65fKENe?=
 =?us-ascii?Q?uUlZaRpNa/yT/DptR6Or9MBTWca5hdIGfo2oci8HbDm6vvu76RVFS1JvSujp?=
 =?us-ascii?Q?vgxDuYJEbxbYoJHIREG158oGC3W3H3I6pJOG9QYp5+BmwW/Sn/X+Ehu/zZPW?=
 =?us-ascii?Q?HC1bzcAAfpK0tCVLfmNud87GE4mmHZybCXZR5M7YCB87miNYxHhtCYFBQEQA?=
 =?us-ascii?Q?ySvMRt/SNbSRIm2OH2L1eJOwmdZghWLASDh82tE3UM2dkdbUJIGz8kb7BkrT?=
 =?us-ascii?Q?dOYKum3CAEJFLNvheTH5h+dgqIB/vMWjf7W7jRUfKfZcCar1ehmjIWO84ye0?=
 =?us-ascii?Q?4VQ4bHDEPaTEezTRhAu6ShVXFfWl2uvKOMzR9QUObY62mcwBSYh9o0v2Ylbc?=
 =?us-ascii?Q?3uffUhnVfrEhJGa+Lkcd2N/JqQJ5YtYVebdR8iqPieqOGmBqjP7Wsq3ilVls?=
 =?us-ascii?Q?1gH7u55ygVSW2WsiK5GOkBJYx7usQr4tyyvFzcAHrjeIUUaGKNAsEhqmhsJ8?=
 =?us-ascii?Q?9I2qWHF7wW/tYQZynmV3MnW4vOqSQnZvhyV1A7Ov3ChaTMBDaHXBhVa0BdQz?=
 =?us-ascii?Q?ZGjX9wm2rfu5at2nE2Si133MAlBy/LV7d/0zXW9dy0vDCoVfw44k5I4xCEQG?=
 =?us-ascii?Q?YMXN4HLKT3EMprI2iJgVLxx1fQYD6S/nLnFN7dtY7Aw+aNAbN3f1Utag0Rbu?=
 =?us-ascii?Q?Sdu3xPvGGTYa0d0mXl+oC3EtMnGdsRZtm+ULALtOjT99WREmcM+WqWysdgHy?=
 =?us-ascii?Q?YXsxsEdC17wfvCoJynJA8sEyVgBr8Lee0Z2H3EDy/rra9H4Irj51GsaVpYCC?=
 =?us-ascii?Q?hYYencdQjTuhPTAnU8sPV6CjxPa2NCINxVhL+8giCIZUbZ9JKmO71NaWecN+?=
 =?us-ascii?Q?20rvJiXK+2CMMpX1oB/vtxYxa8NCBqPS0evNtlRE1v2MYaHILWplKQ3BufIA?=
 =?us-ascii?Q?2vRCqFhr2lo0PIFfDYboNEjvU5TnZaPYKHFQ0DmgG157DznPqO6XhVvrZItN?=
 =?us-ascii?Q?FBxk7w4Yuce+d3DEMawOBFASDML4xzUghfJlAal6nawPTRGnIVuI115SAUSJ?=
 =?us-ascii?Q?WBxw5FPn7+pzKpxIJdEdXR7CcnxFJNi3VSZYOhwedi5uD5wjLbOp1CcQ/DCp?=
 =?us-ascii?Q?OA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695d7258-4670-4bde-b730-08da9ceb4a99
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 22:39:20.9025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLXbCSLDq+hvz27fTMlb9c6D6uzu24lhPsp2TJ+cFDZVzC20rNSfku88Zbe+FgB2W7smODfoIPfGTioH3DiVoUA3143zrWOlTTkR27r6dd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3657
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Monday, Septemb=
er 19, 2022 3:05 PM
>=20
> pci_ids.h already defines PCI_VENDOR_ID_MICROSOFT, and is included via
> linux/pci.h. Use the define instead of the magic number.
>=20
> Signed-off-by: Easwar Hariharan <easwar.hariharan@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 3c833ea..f2efb74 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2052,7 +2052,7 @@ struct hv_device *vmbus_device_create(const guid_t =
*type,
>  	child_device_obj->channel =3D channel;
>  	guid_copy(&child_device_obj->dev_type, type);
>  	guid_copy(&child_device_obj->dev_instance, instance);
> -	child_device_obj->vendor_id =3D 0x1414; /* MSFT vendor ID */
> +	child_device_obj->vendor_id =3D PCI_VENDOR_ID_MICROSOFT;
>=20
>  	return child_device_obj;
>  }
> --
> 1.8.3.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

