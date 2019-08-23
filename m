Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 021489B77C
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2019 21:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388781AbfHWT4t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 23 Aug 2019 15:56:49 -0400
Received: from mail-eopbgr760090.outbound.protection.outlook.com ([40.107.76.90]:39077
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731765AbfHWT4s (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 23 Aug 2019 15:56:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSbytpF2trlVzEdprP6s6uJqzrW0h5BB99nKGhd8/Ap2qrN5sjsWkwt5qdrv4PdNd7vWM6m/6qi4ITX5bDR8OCLCscjbRt4MGF/FW3JcKojncWOyH4eEuZIVX4stqfVnfmkvgGdlvYM0MqOctojPxPaKnAbX8wD1JRpwanYMaZd8G55JpMapk16BqA5w3bxd+6eiZQfqpdl+C8iV48ZxXYnWc2bKC/dHC50Dn1SE7T7QzSnduZrlIltIDmqHANYEsJBm23G9HdQaNy0XFlwr/VS4lQY/iSU7F+Otm96w4nHb0gOMdOUch301a01wEkKXilzlcDiDwoUXBi8bk9pMIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOeVxe9UYuUQLXlJtivshFK7VdMbkjvNgRTzg4gkbMA=;
 b=dTQCa45X2DH+f04vznUkcz7UgySBD83dQu+FgQJY/efY/GV3AcyOb60cTIILQWlmZAMK6D18QCvO5oivngNl/nL1ouB8rKmA+K2WTBXyj97ZESodvJp9KyiMr7QjKyHK0yZeLrhh6BJap1tuu0z2pdSChXaqDsY7sBS0lZglchOTO605Y+Lmdzf7IOCqVe+2Op6OIw4cpFLxfjqmo0FF6mv3FcbgXsEIvxNFnD5cWooLQ05QAMt0Vm6gbv6NKOmsh/zuGvv/ktVDfAGQqAITm2L/GDQXlClVuQoZEl4uPhsAU3u0kOeU3w/Rf+sGbfvaCOfaeGDCBG+wdp+frKqtQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOeVxe9UYuUQLXlJtivshFK7VdMbkjvNgRTzg4gkbMA=;
 b=XGwUavC9vlegg25Bb4IlvsxNUCrBjL3OblKYt8cXVyv1wQ/OqBrxR2NP+0Sxm0zAdJY2WVVzzpaZbSiuP8xBlpkpqJ9flV6yoscT0mypzWTS3eDdk83ud++sXUlPI8hn56jDjc5nVAUy9+cr22CufTSOahqdT84ewmnJZpOtPMM=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0140.namprd21.prod.outlook.com (10.173.173.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.4; Fri, 23 Aug 2019 19:56:45 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::8985:a319:f21:530e]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%8]) with mapi id 15.20.2220.000; Fri, 23 Aug 2019
 19:56:45 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 08/12] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Topic: [PATCH v3 08/12] Drivers: hv: vmbus: Ignore the offers when
 resuming from hibernation
Thread-Index: AQHVVvnez8f5+ZNs+0+5s8sO4QKl7KcJKo+w
Date:   Fri, 23 Aug 2019 19:56:45 +0000
Message-ID: <DM5PR21MB01375F5A46E46079DA611622D7A40@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1566265863-21252-1-git-send-email-decui@microsoft.com>
 <1566265863-21252-9-git-send-email-decui@microsoft.com>
In-Reply-To: <1566265863-21252-9-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-08-23T19:56:42.9471406Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e21d423b-8579-4709-963a-79ab2ea4258c;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d100aea6-4caf-4ea9-2ed3-08d7280406a5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DM5PR21MB0140;
x-ms-traffictypediagnostic: DM5PR21MB0140:|DM5PR21MB0140:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB01405E8D2153778EE2A43F5AD7A40@DM5PR21MB0140.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0138CD935C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(366004)(136003)(396003)(199004)(189003)(305945005)(446003)(26005)(11346002)(81156014)(8676002)(102836004)(6506007)(256004)(14444005)(81166006)(186003)(476003)(486006)(7696005)(7736002)(76176011)(22452003)(4326008)(74316002)(6246003)(3846002)(6116002)(9686003)(10090500001)(55016002)(1511001)(8990500004)(2906002)(66066001)(6436002)(53936002)(5660300002)(14454004)(110136005)(316002)(86362001)(478600001)(2201001)(66476007)(71200400001)(71190400001)(76116006)(66556008)(66946007)(10290500003)(99286004)(25786009)(33656002)(64756008)(66446008)(2501003)(8936002)(229853002)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0140;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e79OlCSOMt0MC27KNbYV1GvgubrRQNBfgy6ymV9MFFQxu9qMAK53RzHtLEAiWa0lSySrMNcJ/QNwYgJJ+wOB63zHw5uIZMR34/3uTMhovSE+9WZ9HAUiWqxN6GeaqiluQCago3bpkTGk98Vizz50YFhlBQ6cS0fygqjWIsVai1n72wPrHqqMDnTdTbBkNn5RfUERR45/LnfZT0aeiYWLhwSszL3QAbB3Ub4iR/RMEgZxOr4gRDk9eKrn54Hcv6P894oTcOfLcL8bQBc+tceyn9ruU0eGmWfrm2tP63bQsBhiOd+dNZgiMHSEC5kslqxRNHJlgnD6FrFGJBbyu72AB7wSV8Rkt9RZKKS/IALDVpAWgHmCL7UziohaTM+rwTPYf8ywGVLVrjJNku45vrWdrz04s/+jxIJ8oSvfKcmjmrI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d100aea6-4caf-4ea9-2ed3-08d7280406a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2019 19:56:45.1344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nti3m18BUriPFIKf0mTFyQBMbLKakpywH69fCSX7OTZFKPd2CHAkU7O0Ih8g1tJS5RuuK2nnTDEmgoMjF5V0m1fG3ifODEmjF8+3C7r09Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0140
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>  Sent: Monday, August 19, 2019 6:52 =
PM
>=20
> When the VM resumes, the host re-sends the offers. We should not add the
> offers to the global vmbus_connection.chn_list again.
>=20
> This patch assumes the RELIDs of the channels don't change across
> hibernation. Actually this is not always true, especially in the case of
> NIC SR-IOV the VF vmbus device's RELID sometimes can change. A later patc=
h
> will address this issue by mapping the new offers to the old channels and
> fixing up the old channels, if necessary.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 29 ++++++++++++++++++++++++++++-
>  drivers/hv/connection.c   | 27 +++++++++++++++++++++++++++
>  drivers/hv/hyperv_vmbus.h |  3 +++
>  3 files changed, 58 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index addcef5..f7a1184 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -854,12 +854,39 @@ void vmbus_initiate_unload(bool crash)
>  static void vmbus_onoffer(struct vmbus_channel_message_header *hdr)
>  {
>  	struct vmbus_channel_offer_channel *offer;
> -	struct vmbus_channel *newchannel;
> +	struct vmbus_channel *oldchannel, *newchannel;
> +	size_t offer_sz;
>=20
>  	offer =3D (struct vmbus_channel_offer_channel *)hdr;
>=20
>  	trace_vmbus_onoffer(offer);
>=20
> +	mutex_lock(&vmbus_connection.channel_mutex);
> +	oldchannel =3D find_primary_channel_by_offer(offer);
> +	mutex_unlock(&vmbus_connection.channel_mutex);
> +
> +	if (oldchannel !=3D NULL) {
> +		atomic_dec(&vmbus_connection.offer_in_progress);
> +
> +		/*
> +		 * We're resuming from hibernation: we expect the host to send
> +		 * exactly the same offers that we had before the hibernation.
> +		 */
> +		offer_sz =3D sizeof(*offer);
> +		if (memcmp(offer, &oldchannel->offermsg, offer_sz) =3D=3D 0)
> +			return;
> +
> +		pr_debug("Mismatched offer from the host (relid=3D%d)\n",
> +			 offer->child_relid);
> +
> +		print_hex_dump_debug("Old vmbus offer: ", DUMP_PREFIX_OFFSET,
> +				     16, 4, &oldchannel->offermsg, offer_sz,
> +				     false);
> +		print_hex_dump_debug("New vmbus offer: ", DUMP_PREFIX_OFFSET,
> +				     16, 4, offer, offer_sz, false);
> +		return;
> +	}
> +
>  	/* Allocate the channel object and save this offer. */
>  	newchannel =3D alloc_channel();
>  	if (!newchannel) {
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index 09829e1..6c7a983 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -337,6 +337,33 @@ struct vmbus_channel *relid2channel(u32 relid)
>  }
>=20
>  /*
> + * find_primary_channel_by_offer - Get the channel object given the new =
offer.
> + * This is only used in the resume path of hibernation.
> + */
> +struct vmbus_channel *
> +find_primary_channel_by_offer(const struct vmbus_channel_offer_channel *=
offer)
> +{
> +	struct vmbus_channel *channel;
> +	const guid_t *inst1, *inst2;
> +
> +	WARN_ON(!mutex_is_locked(&vmbus_connection.channel_mutex));
> +
> +	/* Ignore sub-channel offers. */
> +	if (offer->offer.sub_channel_index !=3D 0)
> +		return NULL;
> +
> +	list_for_each_entry(channel, &vmbus_connection.chn_list, listentry) {
> +		inst1 =3D &channel->offermsg.offer.if_instance;
> +		inst2 =3D &offer->offer.if_instance;
> +
> +		if (guid_equal(inst1, inst2))
> +			return channel;
> +	}
> +
> +	return NULL;
> +}

Any particular reason this new function is in connection.c instead of
putting it in channel_mgmt.c where it is called?

> +
> +/*
>   * vmbus_on_event - Process a channel event notification
>   *
>   * For batched channels (default) optimize host to guest signaling
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 9f7fb6d..c42b46d 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -310,6 +310,9 @@ int vmbus_add_channel_kobj(struct hv_device *device_o=
bj,
>=20
>  struct vmbus_channel *relid2channel(u32 relid);
>=20
> +struct vmbus_channel *
> +find_primary_channel_by_offer(const struct vmbus_channel_offer_channel *=
offer);
> +
>  void vmbus_free_channels(void);
>=20
>  /* Connection interface */
> --
> 1.8.3.1

