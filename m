Return-Path: <linux-hyperv+bounces-9409-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCJjHCJVtGk4kAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9409-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 19:19:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F605288A83
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 19:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97DF932B7A65
	for <lists+linux-hyperv@lfdr.de>; Fri, 13 Mar 2026 18:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ACF3DBD79;
	Fri, 13 Mar 2026 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YP/tg1IF"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAB3D331C;
	Fri, 13 Mar 2026 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773425696; cv=fail; b=PuX8DytrDHvDgc92uEcip+cj8RRWLH2oqxd4WDEUYz0tEDGTElWOQa8h1glGT8YLlNO21ALc3VOvB2Y5jI+j7IaHdu1zcg4CHf3LoRRNTP4Zla9WvRQbrWYiiOybPb3oapeEMk3/qCua8LESRs7quI96i1Pf90Ni0H23v2JQ6z8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773425696; c=relaxed/simple;
	bh=qThJOK3BnMCkA5SShX60uI11z1UeBiuqa3W5J21MpFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Kf9PXXoU5ub2A2uVUuYkqsimE/Cto0GH/KKgRvY586wR+VSKwV5+bHL3bREtZFx3RF5ortWc4oS4w7ucv0+3UBFfxS4omTihlsmw2fNBjaHlYj3di/14Ic3kOgsCPpMuyuoDcWJYE9ik53o1Gzhvo1JuwvrNzB11nUFtkLN7QpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YP/tg1IF; arc=fail smtp.client-ip=52.101.62.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEvkUGYWz7SvnCYugqMQVhr/95k0P+cHgSQK9Ig10LFt8yjROFeFKsFTkDaVci6w8Kxdja0Z04QNCgQjwv48PhEZgHAuSm3Nn+dToS7fg91kbxb9BohtRkMK4Vix0pWX2dYAvlPSxfo/Y0ppzERhjZIIMzrP7jzoia915AN8+BtcdCbETZniiDRk3MlCcWJhoIZ7zhj9tQZJw2zMyxBRQRZGlISdDvTJO4f3HSnEUlNi+9N/t64JI6lBtRQLVycigPrDYmgzhRA0rewBGDx5qHP5CQ0Km4o+tjBNuyfgMzRObizIwU1Q4XiooebaJR4uxp/j60cuOm0kRxOCzW7v7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jznxcn6Nn63Hpa1lbbaZPsankzE0DKOrBlmEW26u+yA=;
 b=Aq+xQfzgZReo1H9QeFF3PzLAOz9M3ao/K7Rz2Ds1G24qPaobpD3/Y7zyB6FWC/sd/ptUuScECKhBCpXyiRig//Kd9uirWzP8TnFE8p/6jQwEuEeC31wnG10sY6qapjis/EFqQ/WQ63ewW8nUCKlSliYEsjhdH3CbWfeu2deNax0m1gEAxD85J2IGLf8gVoauakIeRaW3OuKJ0ZTThd9arYy1nP+9zVD2GDeq99KxzX9oYDPy436WW9X46jmKGfzXLS/K09ju5bg+NCDzAZ30J+dJb078IOrEuyuTs8D1VRbdVSVcoYI5sCd+0KAxV1LIQOE+PMbt/aQ6aPh4jG36pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jznxcn6Nn63Hpa1lbbaZPsankzE0DKOrBlmEW26u+yA=;
 b=YP/tg1IFYZns1ZKab5CGqXHCJMcEM00+7D5aZ3lLL4ZlQdPdsMi1Ui1zCyRuzWKYE9xisAxlJaeY80SyaMXN0Jphm+l5TvAbXZAEswWkoz5ltLtge/WeDBqOq2S6kms0vAeNtWwAsFTWS14g6ppjTnP1u1W5Ryz2dHXxKf/FmsrZzO5j7VeNzvVD3j5S09r2eIFVMMEsxDL8KHs7SmTW5ZqJT9n8eYbeAY1X+AwyNG3TdxKncEGTzeNDYf6mFj5UhBA0+7X7Oh4dayy2zPqWLMMLjd5dWxSuJPrmez/T+zNWEZ2Z2Z6naTNGQDUKg6g3FL4UWylwmvy5PSL0CnadnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB8800.namprd12.prod.outlook.com (2603:10b6:510:26f::12)
 by CY5PR12MB6035.namprd12.prod.outlook.com (2603:10b6:930:2d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Fri, 13 Mar
 2026 18:14:51 +0000
Received: from PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d]) by PH0PR12MB8800.namprd12.prod.outlook.com
 ([fe80::f79d:ddc5:2ad7:762d%4]) with mapi id 15.20.9723.006; Fri, 13 Mar 2026
 18:14:51 +0000
Date: Fri, 13 Mar 2026 14:14:49 -0400
From: Yury Norov <ynorov@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-cifs@vger.kernel.org,
	linux-spi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Brown <broonie@kernel.org>,
	Steve French <sfrench@samba.org>, Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] lib: count_zeros: fix 32/64-bit inconsistency in
 count_trailing_zeros()
Message-ID: <abRUGVW6ZuGioa4Z@yury>
References: <20260312230817.372878-1-ynorov@nvidia.com>
 <20260313171855.GA1744604@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313171855.GA1744604@nvidia.com>
X-ClientProxiedBy: BN0PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:408:143::6) To PH0PR12MB8800.namprd12.prod.outlook.com
 (2603:10b6:510:26f::12)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB8800:EE_|CY5PR12MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: c71f53bf-ea84-458c-04e2-08de812c6b6c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|10070799003|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	XZSrGIIfFrdUG8PRSTJLbyZibG9axDCqmnyNzmIcAch4/RP1wgHCKJfdhdYQabV6Z9k1DBvekOoGhVfwjx9FXDoBCokntWMSH2kPvqjtxtz3g/a93lqKYk5MKKdA7SW0fj54c7DKG0l8LHDw9UZNCYBWn0nCfK+4hTHSvrpYLnb0rnBgMre5SRFRcf7+quUXDL5Hbi9EbH0Oy5kqvB4mtiBcdCbF80RBZoUhV4To9Ar/HQXJaJYxzzzA8em2O103VwzVwkaG+I9P6WnB0aCsBoYnljvT4WLlULVFwM0DL2rsD4SicDCadeY42wUl2mNwmmJfcNExN4a9U3dlOCa7RFbCrhXB1FPM3/0l4AEy5bb4jexIitFCqwhYg7JpF1nu1nRMOto5tcQwmKfqfbI2zVhzl/yvGslENwRKD2wFkbbmjBZ95jL755cPcLWqDzviTV1dN4WRx/WjdEMQdE1VwohkTKez7X3XdZZyIKHJ3AjsWLGf4PO3+OMVv4Cs4e3L7356Ui3dyNIO7+smhyAS3rqDSn0mEnPrnLNbpeA4R8MwXFhq95hkU9op5XtuygOSItflqGZb5H6gtt6Ozt70o7QJgSWHn5LGuRxBPOfZ6WJv+YG8xhiAWwbd6ApYhAsqvA5j3MGPMQU4C/JhP/sqmGFHJnsNVRzrTfOJiq03uBruAvMsHlS+ffClD8ear6pVUONS6xevsdIm4tgmOIkGJEE+s7EE3QJqVuI24dTGwXg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB8800.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(10070799003)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dok6uZWq1MPTd6Aalz96D42Wg6EyP7GnkTzV6XYHFzkR9/T4TX/CvSyZIVrm?=
 =?us-ascii?Q?t27o0vXHrCwlD7hG7HeV6R8bFQxdwlTaYcQkL7hM/3bYACWDI24GyJB20+Fm?=
 =?us-ascii?Q?15Svk3AA5HAO0/YHKP1tbASq3wI9uiPpWelppCcNQH42lJJ2yX3fLPKoEmWO?=
 =?us-ascii?Q?r3jiYc0SDCDFifacUJWCG3n6ARFXEjXjspI6durrydePOqVW/HuWOkuKJLoE?=
 =?us-ascii?Q?lWQB41EtIdRnnnIk7DzVHMK0dz6xcagXrtd9R0BZwDAraVPVNxkEz2ppiQuT?=
 =?us-ascii?Q?TcgpD0WLhzkUwznEgsi6xgh3mpQZz7QDTCvJ5gShK3V0GwKs75g9Se1tnh2K?=
 =?us-ascii?Q?fpmVdCjb+OA0mPncDHXVfPTqCZoSI5dsz0xHH/ocGWPVYTbSJhRETUiieB2q?=
 =?us-ascii?Q?Q9ZJqd8rpQMwT+raSe8iOFFlmiIpYE/7+30DvjdYgW3avLZa4pyhJxf381Lg?=
 =?us-ascii?Q?kchHBTNLcBgOm+ikIVyv9NvSZWQ29jgNW5AaaNYR+VId8Vyl35FdQ56CMA90?=
 =?us-ascii?Q?8DS0F39aRVKXCA/+bRkqFCxwvWsVG0sNt5sbBj/tQG8kBZZZ5ZdkBladvZHA?=
 =?us-ascii?Q?YIZdV/Mf6U5c6trqRrsL+V0R73gKF7vF+yycWgDYZXJD/ebKUvc93y5HIB5i?=
 =?us-ascii?Q?hr8CAQmZVC5eM0dC1JGVkiuEhStPWB32bD+xvzd15t0drsyihFrES3OLpUUX?=
 =?us-ascii?Q?sQ+QlJAqrHUvsSEokZFKm92kNg13/0O6xbkwFvrCR0uGOt9hK3COSLaGcgZh?=
 =?us-ascii?Q?dxKu2XcH2ELVxWPNBGa6o8207vlcfN225JsSRXDEP5ayi4WJPMAHdX3NJ8Fr?=
 =?us-ascii?Q?7T/PXMJv9bO/0gxs9E96StDWMXIOnnqgia3hhmgEbxoNJE0E7cEMEfPBUHKs?=
 =?us-ascii?Q?+q+9WNtTHETFWcpnDViYZJpfKE6KAEV+yADGMkb3A0WVtcfd2bczKyTyXf5x?=
 =?us-ascii?Q?9YpPxgJOCgyyVJTif2P3GSZiATa7dIZpkbtsxtllURxByAVJOjMiHmpOHlG5?=
 =?us-ascii?Q?nDvz44Bmb9+1xFeK+BBog6x8cEZignpwgyw1sGmCrzH+rXpmCooYGX2rHu6N?=
 =?us-ascii?Q?9gjAR+1BVfTeTqB9m3Zx6aacfmXHOuedFTsLRJZkID7IuXgNcfOi5KBenLhn?=
 =?us-ascii?Q?LH6ahmW7ySdt7QcPuZdp4teE6QR7EszQNat198bh1E9DxIMFqr2X7a71GW29?=
 =?us-ascii?Q?f1C9bZgnaKgPMlu1owRBT0mCfhoFXr/6dk000TsOV6Vy35bU4knU8HUXcWqU?=
 =?us-ascii?Q?TxMCopClgx2KaKu+3UL+yqbgNVLNjJKUl6pBvJnU9oOcELhUEwY4VKj2f1jF?=
 =?us-ascii?Q?N9pxbwB/WhW+T9uqKiqsU9ghy8HcduHj3jZ0UW8c3cWbPHJMVBlWzJ54kOJC?=
 =?us-ascii?Q?utnrP2pwvZnCOzw7miIlkznndkVWfHMh1D8wwJsr698sEx0o2kNGkgfSyHA7?=
 =?us-ascii?Q?oafXZJi14QmFQi8OUFF+PCGHmEsr1Yj0IgEQ0BeScLoNIrFmO02/es136M1H?=
 =?us-ascii?Q?bZWtd9YCRDQjSpZgICD5UH/WUnP0c28Zbbn0j4ooD/4iHhUp5hdfkPLABfMU?=
 =?us-ascii?Q?4QogI7qRd8+3Ie0+qIroffQAHMbuKAE/2nPI4JjSxx8Zd78xxzHRCiDdbAcV?=
 =?us-ascii?Q?N7W1uDN4d6KopfMBKMKu3CTwhYAqWOBAKfeDrNK5IgvSSH8mGKQt+ghEy8/K?=
 =?us-ascii?Q?0rY3D183kyF96kYmj9t5+F7+ZvVugwF5QqH1QkIIkxJ0lkbLljEA3pmz6ARq?=
 =?us-ascii?Q?DkKt6mvOgROy2OGLqcg3mxjuI7AsOYlUOyYYkdwEcb4K9ERb2hIG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71f53bf-ea84-458c-04e2-08de812c6b6c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB8800.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:14:51.5228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3JERrbAz2qJl1cdO4o6loxDK4en6g49PqLBUOlI1kqSrTIGXHHWKJbXojMhI+LkUOkM3KN4yTxSLt0DEvYZtyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6035
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9409-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,linux.intel.com,rasmusvillemoes.dk,kernel.org,zx2c4.com,vger.kernel.org,lists.infradead.org,microsoft.com,samba.org,amazon.com,soleen.com];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ynorov@nvidia.com,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1F605288A83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 02:18:55PM -0300, Jason Gunthorpe wrote:
> On Thu, Mar 12, 2026 at 07:08:16PM -0400, Yury Norov wrote:
> > Based on 'sizeof(x) == 4' condition, in 32-bit case the function is wired
> > to ffs(), while in 64-bit case to __ffs(). The difference is substantial:
> > ffs(x) == __ffs(x) + 1. Also, ffs(0) == 0, while __ffs(0) is undefined.
> > 
> > The 32-bit behaviour is inconsistent with the function description, so it
> > needs to get fixed.
> > 
> > There are 9 individual users for the function in 6 different subsystems.
> > Some arches and drivers are 64-bit only:
> >  - arch/loongarch/kvm/intc/eiointc.c;
> >  - drivers/hv/mshv_vtl_main.c;
> >  - kernel/liveupdate/kexec_handover.c;
> > 
> > The others are:
> >  - ib_umem_find_best_pgsz(): as per comment, __ffs() should be correct;
> 
> So long as 32 bit works the same as 64 bit it is correct for ib

This is what the patch does, except that it doesn't account for the
word length. In you case, 'mask' is dma_addr_t, which is u32 or u64
depending ARCH_DMA_ADDR_T_64BIT.

This config is:

        config ARCH_DMA_ADDR_T_64BIT
                def_bool 64BIT || PHYS_ADDR_T_64BIT

And PHYS_ADDR_T_64BIT is simply def_bool 64BIT. So, at least now
dma_addr_t simply follows unsigned long, and thus, the patch is
correct. But IDK what's the history behind this configurations.

Anyways, the patch aligns 32-bit count_trailing_zeros() with the
64-bit one. If you OK with that, as you said, can you please send
an explicit ack?

Thanks,
Yury

