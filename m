Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9813D1D7B
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 07:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhGVEzS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 00:55:18 -0400
Received: from mail-bn8nam12on2138.outbound.protection.outlook.com ([40.107.237.138]:7745
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230210AbhGVEzD (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 00:55:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKxVOkOKDfh7sIzsADcWagy1gMc1MoVnfGc070tXw/+RO0kOe/MfYB8dIX+ViY9BQxNtD7C0WJFb9ZfNt/BxR9y+hhyw+rdXpPL1c/r+18gTN54/HtRrSi0ejPU6EKf/mGR2MFKWbfNrAuKR1AEFKziB2y+m1l3W8CJasum5kK3Gx3Iy2/3FfThHZPR0UuXfq/STQHziO88xxdlwLcxTJuWtUZ3IbT/MQnbZuuPpJ1pkZpdtwvhzhqFBjh+HO8eelctuWWV/CnEUayzWJJLr9eFWTjWpGeOxPiG9hVC77+sYyDqmlJ9l0mw+d5n7oekpt8w5TNVg7BFjP2QQHR8cKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hry3NniSWMF5YJZM0F6Vc+1evXiHB17VOAgqrMgSUds=;
 b=Aqpc91pIsqEVHNbCtBfgWis+/2b/i8Rxx10/xQL3ppwbFCt9ICwc7asZAPbRLUbohGaAficq0Bl6yr6ykPwidChkWJzCt7gYvDgr/Bz7BJcGNOOfmmHQ+fOutyE5E1e8q8xFoiD917hXPbvkKOWf6yCOW32muXBWzUzIk3GBY3gIPRIOOhcucgvolYJF/Y6/LVd1wXDTpeI0x26wVmqEV/vVvzYouLfAFYLB8x3Bb17yyNwHzdDg4WUFdLA09CtMTifYjxTA1tMhUycgZi88dlHyR8y4qFLhlL92bcGL8/C5Xas4891gnsQ/6IxdWOYBKYBDm/nlif2hm0V9TSO+/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hry3NniSWMF5YJZM0F6Vc+1evXiHB17VOAgqrMgSUds=;
 b=O39jb/zgRCCTt13Rn1V7tzcA5njRcmoC5+sMUyXQZTJ44hb1EFZEGs74UWzXFX4OfHhjbWLHsgIV+AJVBSJZtiq75jmpfRhsO3Bm2OSpjGjqQCGTcrLbJ/tpHopCaw3c/3TtU4ZPEPmsJZYWq82JqB6jNGIXX/20uK8TA9fypcU=
Received: from MWHPR21MB1593.namprd21.prod.outlook.com (2603:10b6:301:7c::11)
 by MW4PR21MB1874.namprd21.prod.outlook.com (2603:10b6:303:73::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.2; Thu, 22 Jul
 2021 05:35:31 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::5913:e360:8759:e0f6%6]) with mapi id 15.20.4373.005; Thu, 22 Jul 2021
 05:35:31 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Sonia Sharma <sosha@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sonia Sharma <Sonia.Sharma@microsoft.com>
Subject: RE: [PATCH] hv: Remove unused inline functions in hyperv.h
Thread-Topic: [PATCH] hv: Remove unused inline functions in hyperv.h
Thread-Index: AQHXfnkgUZycti45okycoqnMp3hFsatOeZww
Date:   Thu, 22 Jul 2021 05:35:31 +0000
Message-ID: <MWHPR21MB1593804BE63C6813D66F6BC5D7E49@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <1626903663-23615-1-git-send-email-sosha@linux.microsoft.com>
In-Reply-To: <1626903663-23615-1-git-send-email-sosha@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=327912ea-ea8f-4257-a7d8-a8933c4247cd;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-22T05:34:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b8251cfb-d4f8-4488-3e24-08d94cd28595
x-ms-traffictypediagnostic: MW4PR21MB1874:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1874E986A6C56171B790DD45D7E49@MW4PR21MB1874.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ky5nx8Cf7CpBp487GsXlnh3+2sbVGL2IN4RgrMvHKr/47a7YvKU9r2HFbKFzLvDHQV5kviNiw66Yk9udFPr2y7lb+O4hoqJNtUFneWOb1cX6eTBQwx3poAmWbqNS69Zs/LQMwat7th10JRuvS1BLXNWPh3WOTr5wVwDcLV3+6hsYTdN6NbY7eZV6jG57DPXwdG6NWhLo6TSCETCQWzZpyQvvr7H/lT1ejajwqlC/0qrsqjwUQXXnymUDjOkvH4T+wPJ4mn+rsxJPfXFU0sGm54WyWFZY2uffRuTtIS+61qXYakkH4G73g4k0ZeIe9vebsVz+1KfKyTPlG6Hb0OnttvsOphm5qeEx9fMqNK/tuVZKm6z+F31Q0yTh7SyvErfZc3MRXDG532JWWAWAjRgOtW6yJVCQ1mn4cXxRqaqferYc3sF1XLJCpb03AuGiIsEsPq6PLW1g8pxmqADFP4LTc8IzXfugSdriuxUsWvBcdgBTYH1ut8MdP5z4AnfPworeejhS0Vo9tenLStM8woUlo56msNcGfVDNBt3TCsvrVT2tfatzCKqD0M05/gRN9YLP+qnPeTjYBUN15FgysdsbIfSY0a8qmic8a6HrLvfHgzRhiWs76jL6tpctuMZ8ovzPBfYo+cRlrc0MgGEZ6sCZ8/+gfOmS2AS+RpKuwEZ6FaT4OU6s3Ssz6Dl1RuldcOpU+nlKLelIedHJCwq2jnETvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR21MB1593.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(10290500003)(76116006)(66946007)(52536014)(8936002)(7696005)(55016002)(8676002)(6506007)(508600001)(5660300002)(71200400001)(86362001)(26005)(186003)(66556008)(33656002)(6636002)(38100700002)(82960400001)(110136005)(316002)(2906002)(9686003)(122000001)(66476007)(82950400001)(83380400001)(64756008)(66446008)(8990500004)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hKZCxgHI1KogB0dKg+gqcU5r+osb/IlYNtljDc8sXN19t+cad8W/Y+yx01qF?=
 =?us-ascii?Q?CltjsAPOhWhCgCJO2POEbrkD99x0+EcM95xhQ6EDFi/ARGA5UVyZLV/AXzMy?=
 =?us-ascii?Q?ChGopS05Cgfm+f0jPN9vBZs8eD7AtE3LzUTgNujdAdPGmeKHKW/GSFItJYdP?=
 =?us-ascii?Q?wVMrx90nuv4/oiNO9O1v5D+bxBqCF2XWXiNaRGKp5gvQOQkWMRepkvhl2nUe?=
 =?us-ascii?Q?pGXO63NM7nHcSKgWbQIXbB3eIGCsd+N0DP3hauLulwItAZAvpF3xnuuaQCks?=
 =?us-ascii?Q?Pt37o7iWE8FDhje+j3sAcXtQU7eJzcmvNGvj5/dukpdZV6PsXJrxhHFNAtZm?=
 =?us-ascii?Q?99dYEvoiTgugd1rfsnVuWg6kFbGIhlm7ktb3hIznwCJRpaFDhzpZOZxT+oEu?=
 =?us-ascii?Q?6E6mWM9P+ydLEsdYp1ctZ+zNs+htcBlXPB/WrvwZSiwLSEYXFVfEvdaOyNGr?=
 =?us-ascii?Q?cL6rvDB5jzGxXym/dF4fjay8k0ESiHWxwdL7EbJ2SVIOTAGBPIcJITDLT2SB?=
 =?us-ascii?Q?R57k3VJMxHe19vY0387ZN5EeUhC4ZzqBa5If+3VLqyoV3RDx8xHerjkmLVjh?=
 =?us-ascii?Q?J+1YMTnZR4sf7w6FaSDGsKtcYIMNTNFANea9LvRrZxAGJt0sFOOf/S8NGMmx?=
 =?us-ascii?Q?U7CjmuUlQb++ttmRwdC5HWH/VwrEa2InzAoYVRVRdEVzL4LOhw0lAR4aA0wG?=
 =?us-ascii?Q?+pLtxgLnFZUIma3g9OboyT4+YbEIHIebczsCDdoT2uwAlhoJpDfqG3J7OchF?=
 =?us-ascii?Q?ohHYEFmMT/qhV//L+AKJ4jsFQozexlYMKPCB7sGOSRI1G0MK1v0s3n/R1LYC?=
 =?us-ascii?Q?Y+Pvd0naZsXy5eJQRo898RhDGYdY6zqUbcGI8ZDAxdhfC3NncVDhbXPbME7a?=
 =?us-ascii?Q?D5qCSY1FPqIh7Oji2MdsPqePRiNfUWyTKG2pHWs7mpPyPTalQQudECcyQhtU?=
 =?us-ascii?Q?rLa1s7kiCjm5d5uodR/sGyfECN/w6VY6ngz4AICxaewizET4z9VlUZFe7boA?=
 =?us-ascii?Q?UKoS/rr/OojKeP4xp+sqfzHI6CVMroaLRCfPpabq/t7cKmcF2R0i/TKh4lcs?=
 =?us-ascii?Q?a0G6QFy1CfylcB9iegMtr6H3Y0oyMtG3FfXM+x5JZxmq75tXEIcEnSMZGA4v?=
 =?us-ascii?Q?fuw1Nfn4aknhpWSR9gH/M17yLsgLIVKjAeHCGCtyO9UDA03hMLqe0GSZ92Mn?=
 =?us-ascii?Q?iIFr/H2FU7IyJgfCSiE6p8NixVRzAbvCp5vstFXi8oHlLiEzjkDtw5b8FT+X?=
 =?us-ascii?Q?f6I+ICUdqU+iOrrwmC26OTAwWeBEhLMMc1g2tcQ3YtPwvUeN8YGRW32oNZvd?=
 =?us-ascii?Q?Mb5afNP+rDL1o30AX8FmJn5q?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8251cfb-d4f8-4488-3e24-08d94cd28595
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 05:35:31.5660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YYFl8ErOWa/xod9cdrznCxS+T/qCp34F+ly0wJroHyNS0oAF6L0PRYdbX4MYUhWxi6H2PBc9QxLxZdw/9venGTX8W7DOiNO6/7etbcV3QOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1874
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Sonia Sharma <sosha@linux.microsoft.com> Sent: Wednesday, July 21, 20=
21 2:41 PM
>=20
> There are some unused inline functions in hyperv header file.
> Remove those unused functions.
>=20
> Signed-off-by: Sonia Sharma <sonia.sharma@microsoft.com>
> ---
>  include/linux/hyperv.h | 16 ----------------
>  1 file changed, 16 deletions(-)
>=20
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2e859d2..ddc8713 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -538,12 +538,6 @@ struct vmbus_channel_rescind_offer {
>  	u32 child_relid;
>  } __packed;
>=20
> -static inline u32
> -hv_ringbuffer_pending_size(const struct hv_ring_buffer_info *rbi)
> -{
> -	return rbi->ring_buffer->pending_send_sz;
> -}
> -
>  /*
>   * Request Offer -- no parameters, SynIC message contains the partition =
ID
>   * Set Snoop -- no parameters, SynIC message contains the partition ID
> @@ -1092,16 +1086,6 @@ static inline void set_channel_pending_send_size(s=
truct vmbus_channel *c,
>  	c->outbound.ring_buffer->pending_send_sz =3D size;
>  }
>=20
> -static inline void set_low_latency_mode(struct vmbus_channel *c)
> -{
> -	c->low_latency =3D true;
> -}
> -
> -static inline void clear_low_latency_mode(struct vmbus_channel *c)
> -{
> -	c->low_latency =3D false;
> -}
> -
>  void vmbus_onmessage(struct vmbus_channel_message_header *hdr);
>=20
>  int vmbus_request_offers(void);
> --
> 1.8.3.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

