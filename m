Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576373B8E0A
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jul 2021 09:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhGAHMC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jul 2021 03:12:02 -0400
Received: from mail-bn7nam10on2090.outbound.protection.outlook.com ([40.107.92.90]:24394
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234529AbhGAHMC (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jul 2021 03:12:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nURhVXuzKLo+QJtkVlTup+0l5UgGmjKMq4uSARu1w5PtYLFy93bkLGCJQDJOiJ4Tkf09CzJY8oMb6xYBoGe/kQ5iGsxYH5BzCikcEvlgecsstjHdiGuiBWRy/iT9jaFySR6TsKcus1fCNKzCE4ORCTMsm8gLjz5QPc0WRvazqFIJu6lELYYnBVpkX12prnvE27jmnzjMtDRp2EQjftw9EIXScJR5woLKlz1PkonMKdc3DLI/EpiK3zuU7VPBH+TgWnZneyLhsHLC/Lv610hR4axkkpshaIRC8bl6TpWMRF531jZk59a0HjE7fl/fbS3zXxMET91/iFBqsQDaTcWMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrAnEaAiVzX1v9BdFaU4D//9XOFpnPeY+zJjlZlPKDk=;
 b=oM9MgayY+Mee7ZY6RHyyFlD0ZATZvV+GNQueZ5v5HzZbVJKXyv8mb3p6m5r8zeo191G/mqDnCouRo4eTSap/XrwYYVborO/9YxK3eNZItuvQEu8Y+xeHCJL7iA6QBsoN1CIPhXGf0qjzdRnBId3w1HlvftLfGi9/yP7AoTpXLlOTs765ilRJYwMwjWCj9Ze2pQMI9hC4uDLM++s5aO+YLUXaT7TGrX90nP0bhN60Z42csLeHWup/QZpmPfNRcrxHXPRuo5Z1dcASAb7ba/+oLMpv1fnZaQ1gjmihMkL8vYDTQcEGbu3ZXrQJ4Gg8WbjKHucxaQjQdiiRzO0WflpbqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jrAnEaAiVzX1v9BdFaU4D//9XOFpnPeY+zJjlZlPKDk=;
 b=b5Kq177dqj1Ytr5dGM/ugUDaLjGcOQQD2NT5gzm7PYtIeYkPAD+Eh1kacrX6OEsC99GBkpwRoIegrUtLW6xymb8elqVuQKnGnEzufeWb/yacXJZV/e1WKU+zbudnvQ697GoH3j933UDCT4y0sY5JcwiBFuwtB8tQ7tY95IRQAek=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by SJ0PR21MB1871.namprd21.prod.outlook.com (2603:10b6:a03:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.2; Thu, 1 Jul
 2021 07:09:29 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::f126:bfd2:f903:62a3%5]) with mapi id 15.20.4308.007; Thu, 1 Jul 2021
 07:09:29 +0000
From:   Long Li <longli@microsoft.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     Jonathan Corbet <corbet@lwn.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Andra Paraschiv <andraprs@amazon.com>,
        Siddharth Gupta <sidgup@codeaurora.org>,
        Hannes Reinecke <hare@suse.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Topic: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
Thread-Index: AQHXalTR5lVKFlOZkEmq8/y9Kgt/basqsOKAgAMHtBA=
Date:   Thu, 1 Jul 2021 07:09:28 +0000
Message-ID: <BY5PR21MB15062914C8301F2EF9C24F15CE009@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <1624689020-9589-1-git-send-email-longli@linuxonhyperv.com>
 <1624689020-9589-3-git-send-email-longli@linuxonhyperv.com>
 <f5155516-4054-459a-c23c-a787fa429e5e@kernel.org>
In-Reply-To: <f5155516-4054-459a-c23c-a787fa429e5e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=54b0c8b8-a6b2-4fe9-b7d7-7e481c389a01;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-07-01T06:59:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 188d451a-08cb-48d9-2524-08d93c5f2afe
x-ms-traffictypediagnostic: SJ0PR21MB1871:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <SJ0PR21MB1871FF6420A7E76A47D9367DCE009@SJ0PR21MB1871.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVekaCSdMZcTf4onDnz6VLTOk8G/tcRrPve9bZ8oMz55Hx04EtXfxfRvvbikQDQdOCpRYXYuv1uSEu+kcxpQD+0s9Q+V6Y84IOOg1X3pKVClLSULnEbSHLqt9VdYaVaKErQ4bO3c6LoiAkJ4XrCX4ShVMU+yl+sf0xV5zh9j4aWNOSBtsF89jVhWNkt9KMD64AMWbxAqimehxdYID4QspGMz9h9dXZeyB07jlUNIq86TBDSnoxekwXKQ66MbbGtYu5jb/fN8JXobh4AQUHSm61Uiqu3V5EnVnNUQnVYzK0VpMRpKaAonZr6gxVaJW4vScA2bhCCGtqlF7OADlzmtiojl06yDPImZDYESd7jN7IivTR3SNQRxTf+Po7ocGPuTXEjTjon5g6hBmL7yocttyhiy+tOsW+6RUgvQodsuMsa4Ygcj0VVpH9tFVdQQi+zt7MV4mJikuaWwnup4RneJ4WKzhQrQVgEigorROyveMstCtpkRAaikOGLqtKJEuW3IySsPbemZYyXAe8nDC+QfbxjWxx39AAqdEuQnY0LDhQPh1TZjE2nb3Fy4TwLK/cM9MrKzewYv6JKs2WCbGUtx+IQasElc7NLYVR2JX87rf3ETfOuA3JolR/L/34vcvCgjl0k7E737aPEmovhDnwteJWM94qfIvj+cqgjk4sAMvICn0Gx7ZhdqTC6w9NN4Mh09W14C7d/4XQ4RohnuTyXiwuf6Tyaxam6mZt0Ht6SyXQ1rAlptsFzxAqq+Jwpq974HmJOBQu6hoix1aYBnDL1tQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(9686003)(122000001)(33656002)(38100700002)(8936002)(86362001)(186003)(8676002)(26005)(55016002)(66946007)(76116006)(2906002)(5660300002)(82950400001)(82960400001)(7416002)(30864003)(66476007)(4326008)(66556008)(64756008)(52536014)(66446008)(54906003)(316002)(6506007)(478600001)(83380400001)(8990500004)(110136005)(7696005)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NgGjfvz0kEhSlSTf9qW7Z8DbxYyv4wvrn079xHEJnhIRzTX65IWTXWZUmFF8?=
 =?us-ascii?Q?0o5AZZrRubC3dn6P2eJh5IjDJ5JcnUd21uPibOIOtUukOEQZidmAit7zr0Bj?=
 =?us-ascii?Q?ymfY5qwcVAW3hyb/VdNWwy/72OfNZHp17tdIRgav4J8k79AOHj+dfEwACp5v?=
 =?us-ascii?Q?9PfK7VZzQqcjNjLDLj9SKThEUfrVDKlvHNw9ywcoJCaPiO6wJAVhAeS7bJAR?=
 =?us-ascii?Q?E4HSOEJ3IsxsfW7153MbX/X0JvoASSLokoBMQRFdW3MTC9W5AO7pGZY89A68?=
 =?us-ascii?Q?sPWYRxw2JselBg8f8tDHJbr5szO74GcF0lli/5UeHc4ObvrCx9enyK9F8imv?=
 =?us-ascii?Q?l5X9SrJPZ27us+DqhGys4RVYrCRprV7rpmaNYFqtecmKYMieO+97fMWygiYP?=
 =?us-ascii?Q?12Y3nKraqaOCWuXzIAuHoD15u7IbrX/N0EJC7qZ59N1ptA9kmfWMps7aZZzq?=
 =?us-ascii?Q?gUAOA7T9gGqqs6oIvGBYzPwrIUCtsrPd8pjsySAmLvLa1ewy01EpJK7t34p1?=
 =?us-ascii?Q?n+LjRsi96OUZqQUVPzD7rXJz/XZFKxyGzRweEQcvxyfvZ01QFjW6cOTW34Up?=
 =?us-ascii?Q?bzOUfbMHloMqXCwdvo7sPLvhH+ya4Tf3PKA+4Rl+aJj1of3kl6MLuNSlZmhA?=
 =?us-ascii?Q?Nm1ceYvY6mFK35MALcCzuQsit+AVqldHwuEKwSUQXAJm+hlPhQOrzKXE52er?=
 =?us-ascii?Q?R8gc0Sj4eZ7RENp0Gjrl/p9s5HAB8Umn67pILDIPaVNGW8prwl4jLSGG3Z0B?=
 =?us-ascii?Q?qObcYAWe4cLK4oXM5vYbUYmVazSH33UZMpzv43hMwSvnchyO7ybt/m3jecBn?=
 =?us-ascii?Q?pihKFgFHqs2RzHa1J+xH9YQ1q5wPXYKi0yDzKNmS0Ur9VXCq5R43xG86Dgc3?=
 =?us-ascii?Q?aTbP4I6/qbQVUxeDDumnmH/QqyLqPj4Df3e9QrbltotjzEgd3mMP3YOTprzJ?=
 =?us-ascii?Q?/RMsOxhrVdAL9rtbMldz+gSz4PtKQ7w8RWhUwZR/mPzO+lf8TKgqm1Fb2JEX?=
 =?us-ascii?Q?3fQHinWDFZYhZsbZ3jxF5xlFUjT3RZWryKvraQcwRbtLT4MVOler2DfGT0pc?=
 =?us-ascii?Q?b2AjRQHNuVvIHutfQu9mGJSaW88s+Ux9Au488t6jkc9Pu3BTUiGzj41JrJho?=
 =?us-ascii?Q?C5zJfiaq6czEFfD01jx0GC8tpoa/7kfkAWqbSVyI6L7gX9t6YTnH4yyuo1kq?=
 =?us-ascii?Q?Zjs2EowTsxQ0fwF0eQdh/2bd4EdQI6Ai9WU/JJEmWuhr0yJLRH7EP8A/OkIB?=
 =?us-ascii?Q?J4Wg+nmve5Fa/abeT+n2UZ0Ym/uJoKJA2kGtnZCZzuqaElKNq64yTOPeVuw0?=
 =?us-ascii?Q?RDiY6iUkFBQ9V8cfZ2ohw7ef?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188d451a-08cb-48d9-2524-08d93c5f2afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2021 07:09:28.9229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4RGC7LYwrp8zlBUgKau61ZZkscaFh7qWcg6b1eTcBdsqTpjpP76YOAezLstEDIgnAy8XuvKrQz8F/sYECIKLNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1871
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: Re: [Patch v2 2/3] Drivers: hv: add Azure Blob driver
>=20
> On 26. 06. 21, 8:30, longli@linuxonhyperv.com wrote:
> > Azure Blob storage provides scalable and durable data storage for Azure=
.
> > (https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Faz=
u
> > re.microsoft.com%2Fen-
> us%2Fservices%2Fstorage%2Fblobs%2F&amp;data=3D04%7
> >
> C01%7Clongli%40microsoft.com%7Cf5787b443bd04a8a2db708d93ad9ec59
> %7C72f9
> >
> 88bf86f141af91ab2d7cd011db47%7C1%7C0%7C637605529942807730%7C
> Unknown%7C
> >
> TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
> XVC
> >
> I6Mn0%3D%7C1000&amp;sdata=3Dbu0G8il7D%2F3emZkPn8FXIHWWff0WPORF
> 5CBfHAsIOI
> > 4%3D&amp;reserved=3D0)
> >
> > This driver adds support for accelerated access to Azure Blob storage.
> > As an alternative to REST APIs, it provides a fast data path that uses
> > host native network stack and secure direct data link for storage serve=
r
> access.
> >
> ...
> > Cc: Jiri Slaby <jirislaby@kernel.org>
>=20
> I am just curious, why am I CCed? Anyway, some comments below:
>=20
> > --- /dev/null
> > +++ b/drivers/hv/azure_blob.c
> > @@ -0,0 +1,655 @@
> ...
> > +static void az_blob_on_channel_callback(void *context) {
> > +	struct vmbus_channel *channel =3D (struct vmbus_channel *)context;
>=20
> Have you fed this patch through checkpatch?

Yes, it didn't throw out any errors.

>=20
> > +	const struct vmpacket_descriptor *desc;
> > +
> > +	az_blob_dbg("entering interrupt from vmbus\n");
> > +	foreach_vmbus_pkt(desc, channel) {
> > +		struct az_blob_vsp_request_ctx *request_ctx;
> > +		struct az_blob_vsp_response *response;
> > +		u64 cmd_rqst =3D vmbus_request_addr(&channel->requestor,
> > +					desc->trans_id);
> > +		if (cmd_rqst =3D=3D VMBUS_RQST_ERROR) {
> > +			az_blob_err("incorrect transaction id %llu\n",
> > +				desc->trans_id);
> > +			continue;
> > +		}
> > +		request_ctx =3D (struct az_blob_vsp_request_ctx *) cmd_rqst;
> > +		response =3D hv_pkt_data(desc);
> > +
> > +		az_blob_dbg("got response for request %pUb status %u "
> > +			"response_len %u\n",
> > +			&request_ctx->request->guid, response->error,
> > +			response->response_len);
> > +		request_ctx->request->response.status =3D response->error;
> > +		request_ctx->request->response.response_len =3D
> > +			response->response_len;
> > +		complete(&request_ctx->wait_vsp);
> > +	}
> > +
> > +}
> ...
> > +static long az_blob_ioctl_user_request(struct file *filp, unsigned
> > +long arg) {
> > +	struct az_blob_device *dev =3D &az_blob_dev;
> > +	struct az_blob_file_ctx *file_ctx =3D filp->private_data;
> > +	char __user *argp =3D (char __user *) arg;
> > +	struct az_blob_request_sync request;
> > +	struct az_blob_vsp_request_ctx request_ctx;
> > +	unsigned long flags;
> > +	int ret;
> > +	size_t request_start, request_num_pages =3D 0;
> > +	size_t response_start, response_num_pages =3D 0;
> > +	size_t data_start, data_num_pages =3D 0, total_num_pages;
> > +	struct page **request_pages =3D NULL, **response_pages =3D NULL;
> > +	struct page **data_pages =3D NULL;
> > +	struct vmbus_packet_mpb_array *desc;
> > +	u64 *pfn_array;
> > +	int desc_size;
> > +	int page_idx;
> > +	struct az_blob_vsp_request *vsp_request;
>=20
> Ugh, see further.
>=20
> > +
> > +	/* Fast fail if device is being removed */
> > +	if (dev->removing)
> > +		return -ENODEV;
> > +
> > +	if (!az_blob_safe_file_access(filp)) {
> > +		az_blob_dbg("process %d(%s) changed security contexts
> after"
> > +			" opening file descriptor\n",
> > +			task_tgid_vnr(current), current->comm);
> > +		return -EACCES;
> > +	}
> > +
> > +	if (copy_from_user(&request, argp, sizeof(request))) {
> > +		az_blob_dbg("don't have permission to user provided
> buffer\n");
> > +		return -EFAULT;
> > +	}
> > +
> > +	az_blob_dbg("az_blob ioctl request guid %pUb timeout %u
> request_len %u"
> > +		" response_len %u data_len %u request_buffer %llx "
> > +		"response_buffer %llx data_buffer %llx\n",
> > +		&request.guid, request.timeout, request.request_len,
> > +		request.response_len, request.data_len,
> request.request_buffer,
> > +		request.response_buffer, request.data_buffer);
> > +
> > +	if (!request.request_len || !request.response_len)
> > +		return -EINVAL;
> > +
> > +	if (request.data_len && request.data_len < request.data_valid)
> > +		return -EINVAL;
> > +
> > +	init_completion(&request_ctx.wait_vsp);
> > +	request_ctx.request =3D &request;
> > +
> > +	/*
> > +	 * Need to set rw to READ to have page table set up for passing to VS=
P.
> > +	 * Setting it to WRITE will cause the page table entry not allocated
> > +	 * as it's waiting on Copy-On-Write on next page fault. This doesn't
> > +	 * work in this scenario because VSP wants all the pages to be presen=
t.
> > +	 */
> > +	ret =3D get_buffer_pages(READ, (void __user *) request.request_buffer=
,
>=20
> Does this need __force for sparse not to complain?

I didn't run sparse for the patch. Will look into it. Thanks for the pointe=
r.

>=20
> > +		request.request_len, &request_pages, &request_start,
> > +		&request_num_pages);
> > +	if (ret)
> > +		goto get_user_page_failed;
> > +
> > +	ret =3D get_buffer_pages(READ, (void __user *)
> request.response_buffer,
> > +		request.response_len, &response_pages, &response_start,
> > +		&response_num_pages);
> > +	if (ret)
> > +		goto get_user_page_failed;
> > +
> > +	if (request.data_len) {
> > +		ret =3D get_buffer_pages(READ,
> > +			(void __user *) request.data_buffer, request.data_len,
> > +			&data_pages, &data_start, &data_num_pages);
> > +		if (ret)
> > +			goto get_user_page_failed;
> > +	}
> > +
> > +	total_num_pages =3D request_num_pages + response_num_pages +
> > +				data_num_pages;
> > +	if (total_num_pages > AZ_BLOB_MAX_PAGES) {
> > +		az_blob_dbg("number of DMA pages %lu buffer
> exceeding %u\n",
> > +			total_num_pages, AZ_BLOB_MAX_PAGES);
> > +		ret =3D -EINVAL;
> > +		goto get_user_page_failed;
> > +	}
> > +
> > +	/* Construct a VMBUS packet and send it over to VSP */
> > +	desc_size =3D sizeof(struct vmbus_packet_mpb_array) +
> > +			sizeof(u64) * total_num_pages;
> > +	desc =3D kzalloc(desc_size, GFP_KERNEL);
>=20
> Smells like a call for struct_size().

Yes it's a good idea to use struct_size. Will change this.
>=20
> > +	vsp_request =3D kzalloc(sizeof(*vsp_request), GFP_KERNEL);
> > +	if (!desc || !vsp_request) {
> > +		kfree(desc);
> > +		kfree(vsp_request);
> > +		ret =3D -ENOMEM;
> > +		goto get_user_page_failed;
> > +	}
> > +
> > +	desc->range.offset =3D 0;
> > +	desc->range.len =3D total_num_pages * PAGE_SIZE;
> > +	pfn_array =3D desc->range.pfn_array;
> > +	page_idx =3D 0;
> > +
> > +	if (request.data_len) {
> > +		fill_in_page_buffer(pfn_array, &page_idx, data_pages,
> > +			data_num_pages);
> > +		vsp_request->data_buffer_offset =3D data_start;
> > +		vsp_request->data_buffer_length =3D request.data_len;
> > +		vsp_request->data_buffer_valid =3D request.data_valid;
> > +	}
> > +
> > +	fill_in_page_buffer(pfn_array, &page_idx, request_pages,
> > +		request_num_pages);
> > +	vsp_request->request_buffer_offset =3D request_start +
> > +						data_num_pages * PAGE_SIZE;
> > +	vsp_request->request_buffer_length =3D request.request_len;
> > +
> > +	fill_in_page_buffer(pfn_array, &page_idx, response_pages,
> > +		response_num_pages);
> > +	vsp_request->response_buffer_offset =3D response_start +
> > +		(data_num_pages + request_num_pages) * PAGE_SIZE;
> > +	vsp_request->response_buffer_length =3D request.response_len;
> > +
> > +	vsp_request->version =3D 0;
> > +	vsp_request->timeout_ms =3D request.timeout;
> > +	vsp_request->operation_type =3D AZ_BLOB_DRIVER_USER_REQUEST;
> > +	guid_copy(&vsp_request->transaction_id, &request.guid);
> > +
> > +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> > +	list_add_tail(&request_ctx.list, &file_ctx->vsp_pending_requests);
> > +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
> > +
> > +	az_blob_dbg("sending request to VSP\n");
> > +	az_blob_dbg("desc_size %u desc->range.len %u desc-
> >range.offset %u\n",
> > +		desc_size, desc->range.len, desc->range.offset);
> > +	az_blob_dbg("vsp_request data_buffer_offset %u
> data_buffer_length %u "
> > +		"data_buffer_valid %u request_buffer_offset %u "
> > +		"request_buffer_length %u response_buffer_offset %u "
> > +		"response_buffer_length %u\n",
> > +		vsp_request->data_buffer_offset,
> > +		vsp_request->data_buffer_length,
> > +		vsp_request->data_buffer_valid,
> > +		vsp_request->request_buffer_offset,
> > +		vsp_request->request_buffer_length,
> > +		vsp_request->response_buffer_offset,
> > +		vsp_request->response_buffer_length);
> > +
> > +	ret =3D vmbus_sendpacket_mpb_desc(dev->device->channel, desc,
> desc_size,
> > +		vsp_request, sizeof(*vsp_request), (u64) &request_ctx);
> > +
> > +	kfree(desc);
> > +	kfree(vsp_request);
> > +	if (ret)
> > +		goto vmbus_send_failed;
> > +
> > +	wait_for_completion(&request_ctx.wait_vsp);
>=20
> Provided this is ioctl, this should likely be interruptible. You don't wa=
nt to
> account to I/O load. The same likely for az_blob_fop_release.

The reason for wait is that the memory for I/O is pinned and passed to the =
host for direct I/O. Now the host owns those memory, and we can't do anythi=
ng to those memory until the host  releases ownership.

>=20
> > +
> > +	/*
> > +	 * At this point, the response is already written to request
> > +	 * by VMBUS completion handler, copy them to user-mode buffers
> > +	 * and return to user-mode
> > +	 */
> > +	if (copy_to_user(argp +
> > +			offsetof(struct az_blob_request_sync,
> > +				response.status),
> > +			&request.response.status,
>=20
> This is ugly, why don't you make argp the appropriate pointer instead of =
char
> *? You'd need not do copy_to_user twice then, right?
>=20
> > +			sizeof(request.response.status))) {
> > +		ret =3D -EFAULT;
> > +		goto vmbus_send_failed;
> > +	}
> > +
> > +	if (copy_to_user(argp +
> > +			offsetof(struct az_blob_request_sync,
> > +				response.response_len),
>=20
> The same here.

I'll fix the pointers.

>=20
> > +			&request.response.response_len,
> > +			sizeof(request.response.response_len)))
> > +		ret =3D -EFAULT;
> > +
> > +vmbus_send_failed:
> > +	spin_lock_irqsave(&file_ctx->vsp_pending_lock, flags);
> > +	list_del(&request_ctx.list);
> > +	if (list_empty(&file_ctx->vsp_pending_requests))
> > +		wake_up(&file_ctx->wait_vsp_pending);
> > +	spin_unlock_irqrestore(&file_ctx->vsp_pending_lock, flags);
> > +
> > +get_user_page_failed:
> > +	free_buffer_pages(request_num_pages, request_pages);
> > +	free_buffer_pages(response_num_pages, response_pages);
> > +	free_buffer_pages(data_num_pages, data_pages);
> > +
> > +	return ret;
> > +}
>=20
> This function is overly long. Care to split it (e.g. moving away the init=
ialization
> of the structs and the debug stuff)?

This is true. I'm looking for ways to refactor it.

>=20
> > +
> > +static long az_blob_fop_ioctl(struct file *filp, unsigned int cmd,
> > +	unsigned long arg)
> > +{
> > +	long ret =3D -EIO;
>=20
> EINVAL would be more appropriate.

Good point. I'll fix it.

>=20
> > +
> > +	switch (cmd) {
> > +	case IOCTL_AZ_BLOB_DRIVER_USER_REQUEST:
> > +		if (_IOC_SIZE(cmd) !=3D sizeof(struct az_blob_request_sync))
> > +			return -EINVAL;
>=20
> How can that happen, provided the switch (cmd) and case?

I see some other drivers checking it. It's probably not needed. Will remove=
 it.

>=20
> > +		ret =3D az_blob_ioctl_user_request(filp, arg);
> > +		break;
>=20
> Simply:
> return az_blob_ioctl_user_request(filp, arg);
>=20
> > +
> > +	default:
> > +		az_blob_dbg("unrecognized IOCTL code %u\n", cmd);
> > +	}
> > +
> > +	return ret;
>=20
> So return -EINVAL here directly now.
>=20
> > +}
> ...
> > +static int az_blob_connect_to_vsp(struct hv_device *device, u32
> > +ring_size) {
> > +	int ret;
> ...
> > +	int rc;
>=20
>=20
> Sometimes ret, sometimes rc, could you unify the two?

Will fix this.

>=20
> > +static int __init az_blob_drv_init(void) {
> > +	int ret;
> > +
> > +	ret =3D vmbus_driver_register(&az_blob_drv);
> > +	return ret;
>=20
> Simply:
> return vmbus_driver_register(&az_blob_drv);
>=20
> regards,
> --
> --
> js
> suse labs

Thank you!

Long
