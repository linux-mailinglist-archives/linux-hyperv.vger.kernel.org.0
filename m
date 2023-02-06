Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7914B68C13E
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Feb 2023 16:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjBFPZf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Feb 2023 10:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFPZe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Feb 2023 10:25:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654D629433
        for <linux-hyperv@vger.kernel.org>; Mon,  6 Feb 2023 07:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675697092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UeRsUwXraH00cd2sE5Kq7ZYAcSvC5OMPd9fEpRmgyQk=;
        b=SENYgnakRJhx/uNe3a8pMjJAVC7mnf0NqW59TnQRnupUIGn01AVsYTSqhH8lhT3PvbWc0y
        tfqjdvEofjMBjK/b+Ns056kOON8Pr2zW7MEIf5v1Q6AdC1f1GSEsG3jSk7ogJ3eDyp/0YF
        PNUt2KUC8qEqUjsf/jDhoypBO+Kwne8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-352-RJztv-YbNHGzSkzF7vckjg-1; Mon, 06 Feb 2023 10:24:51 -0500
X-MC-Unique: RJztv-YbNHGzSkzF7vckjg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A01A1885627;
        Mon,  6 Feb 2023 15:24:49 +0000 (UTC)
Received: from plouf.local (ovpn-192-160.brq.redhat.com [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5D9FC15BA0;
        Mon,  6 Feb 2023 15:24:45 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Jiri Kosina <jikos@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev
In-Reply-To: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
References: <20230130-hid-const-ll-driver-v1-0-3fc282b3b1d0@weissschuh.net>
Subject: Re: [PATCH 0/9] HID: Constify lowlevel HID drivers
Message-Id: <167569708530.2863874.629972838322099394.b4-ty@redhat.com>
Date:   Mon, 06 Feb 2023 16:24:45 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, 30 Jan 2023 03:59:36 +0000, Thomas Weißschuh wrote:
> Since 52d225346904 ("HID: Make lowlevel driver structs const") the
> lowlevel HID drivers are only exposed as const.
> 
> Take advantage of this to constify the underlying structures, too.
> 
> 

Applied to hid/hid.git (for-6.3/hid-core), thanks!

[1/9] HID: amd_sfh: Constify lowlevel HID driver
      https://git.kernel.org/hid/hid/c/65b7015bfe16
[2/9] HID: hyperv: Constify lowlevel HID driver
      https://git.kernel.org/hid/hid/c/d38213a911c5
[3/9] HID: logitech-dj: Constify lowlevel HID driver
      https://git.kernel.org/hid/hid/c/662eee8d46df
[4/9] HID: steam: Constify lowlevel HID driver
      https://git.kernel.org/hid/hid/c/ddb6792f0ef2
[5/9] HID: intel-ish-hid: Constify lowlevel HID driver
      https://git.kernel.org/hid/hid/c/3352c3e0bf9b
[6/9] HID: surface-hid: Constify lowlevel HID driver
      https://git.kernel.org/hid/hid/c/dd350afc1757
[7/9] platform/x86: asus-tf103c-dock: Constify lowlevel HID driver
      https://git.kernel.org/hid/hid/c/63509b149f1b
[8/9] platform/x86: asus-tf103c-dock: Constify toprow keymap
      https://git.kernel.org/hid/hid/c/783c3394b493
[9/9] staging: greybus: hid: Constify lowlevel HID driver
      https://git.kernel.org/hid/hid/c/ff17bb876014

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

