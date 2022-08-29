Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE85A50BB
	for <lists+linux-hyperv@lfdr.de>; Mon, 29 Aug 2022 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiH2PyM (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 29 Aug 2022 11:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiH2PyL (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 29 Aug 2022 11:54:11 -0400
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECA96749;
        Mon, 29 Aug 2022 08:54:09 -0700 (PDT)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.0.0)
 id 936fe8cf992e9b5f; Mon, 29 Aug 2022 17:54:08 +0200
Received: from kreacher.localnet (public-gprs523165.centertel.pl [31.61.162.222])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 957EF66D25B;
        Mon, 29 Aug 2022 17:54:06 +0200 (CEST)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Mark Brown <broonie@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-hyperv@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH v2 5/5] ACPI: Drop parent field from struct acpi_device
Date:   Mon, 29 Aug 2022 17:54:06 +0200
Message-ID: <5617470.DvuYhMxLoT@kreacher>
In-Reply-To: <a0cab176-3c3a-707a-02c3-74ffc1b4926e@huawei.com>
References: <12036348.O9o76ZdvQC@kreacher> <5857822.lOV4Wx5bFT@kreacher> <a0cab176-3c3a-707a-02c3-74ffc1b4926e@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 31.61.162.222
X-CLIENT-HOSTNAME: public-gprs523165.centertel.pl
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdekuddgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecujffqoffgrffnpdggtffipffknecuuegrihhlohhuthemucduhedtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhgggfgtsehtufertddttdejnecuhfhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqnecuggftrfgrthhtvghrnhepvdffueeitdfgvddtudegueejtdffteetgeefkeffvdeftddttdeuhfegfedvjefhnecukfhppeefuddriedurdduiedvrddvvddvnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepfedurdeiuddrudeivddrvddvvddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepvdehpdhrtghpthhtoheplhhinhhugidqrggtphhisehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhuohhhrghnjhhunheshhhurgifvghirdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtgho
 mhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkhihssehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohephhgrihihrghnghiisehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepshhthhgvmhhmihhnsehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepfigvihdrlhhiuheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvtghuihesmhhitghrohhsohhfthdrtghomhdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhgvrghsrdhnohgvvhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehmihgthhgrvghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgrrdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegjvghhvgiikhgvlhfuhheusehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhugidqhhihphgvrhhvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqshhpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqkhgvrhhnvghlsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqrghrmhdqmhhsmhesvhhgv
 ghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtoheprghgrhhoshhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsjhhorhhnrdgrnhguvghrshhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopehkohhnrhgrugdrugihsggtihhosehsohhmrghinhhlihhnvgdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=25 Fuz1=25 Fuz2=25
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Saturday, August 27, 2022 3:19:33 PM CEST Hanjun Guo wrote:
> Hi Rafael,
> 
> On 2022/8/25 0:59, Rafael J. Wysocki wrote:
> > Index: linux-pm/include/acpi/acpi_bus.h
> > ===================================================================
> > --- linux-pm.orig/include/acpi/acpi_bus.h
> > +++ linux-pm/include/acpi/acpi_bus.h
> > @@ -365,7 +365,6 @@ struct acpi_device {
> >   	int device_type;
> >   	acpi_handle handle;		/* no handle for fixed hardware */
> >   	struct fwnode_handle fwnode;
> > -	struct acpi_device *parent;
> >   	struct list_head wakeup_list;
> >   	struct list_head del_list;
> >   	struct acpi_device_status status;
> > @@ -458,6 +457,14 @@ static inline void *acpi_driver_data(str
> >   #define to_acpi_device(d)	container_of(d, struct acpi_device, dev)
> >   #define to_acpi_driver(d)	container_of(d, struct acpi_driver, drv)
> >   
> > +static inline struct acpi_device *acpi_dev_parent(struct acpi_device *adev)
> > +{
> > +	if (adev->dev.parent)
> > +		return to_acpi_device(adev->dev.parent);
> > +
> > +	return NULL;
> > +}
> > +
> >   static inline void acpi_set_device_status(struct acpi_device *adev, u32 sta)
> >   {
> >   	*((u32 *)&adev->status) = sta;
> > @@ -478,6 +485,7 @@ void acpi_initialize_hp_context(struct a
> >   /* acpi_device.dev.bus == &acpi_bus_type */
> >   extern struct bus_type acpi_bus_type;
> >   
> > +struct acpi_device *acpi_dev_parent(struct acpi_device *adev);
> 
> We have a static inline function above, is it duplicated here?
> Or did I miss some use cases?

No, you didn't, it is redundant.

I've just sent a fix for this.

Thanks!



