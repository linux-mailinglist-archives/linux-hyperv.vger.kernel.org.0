Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8823631DA50
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Feb 2021 14:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbhBQNYR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Feb 2021 08:24:17 -0500
Received: from mail2.protonmail.ch ([185.70.40.22]:62033 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhBQNXz (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Feb 2021 08:23:55 -0500
Date:   Wed, 17 Feb 2021 13:22:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1613568190;
        bh=kihUeknw7T3cBMLdji0A3QX3xelfw0VfedYTqbAucZw=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=qxAOlepGHO1QIZ0m4ucWRvCBzFopBiN7XtvMYErWQZlNAQ89Zy3YhJoXj4eKujNJ3
         gdWC+bGpjgKhxJEmFzPM8pDv0+o53/t31rWdM+yGsV3LV1uhdS83RewrUMRmModm7C
         r/2MQgFYIGx/MLulhRAUh7iQ/8+rJKZCgxhS709gcEMikmRJ6DHrz7mICJ/z12Odt6
         w1irnflwwPV/E1Fouk5CYP+R9JV5B07ZaOz1FarwHfUUgt41DH5+ySqIUT1e6VsfcF
         rDwT96ApM8okFXdP1alFL9jCRwe4XVvFTvESHSoKqBIKPvFYucgLLCkTtSbd8CweEa
         YQadmcJ7HWeMA==
To:     Deepak Rawat <drawat.floss@gmail.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Wei Hu <weh@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH v3 1/2] drm/hyperv: Add DRM driver for hyperv synthetic video device
Message-ID: <RTH7ReroyaiuwV4na7jvXgaUVHZydoksEf6N1fD_5baGD33auW8TAqtfhOE9WquzDFooXhdGQLZfd5CxgIDRbq7OoM67dtutwHp1SrNRLVA=@emersion.fr>
In-Reply-To: <20210216003959.802492-1-drawat.floss@gmail.com>
References: <20210216003959.802492-1-drawat.floss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tuesday, February 16th, 2021 at 1:39 AM, Deepak Rawat <drawat.floss@gmai=
l.com> wrote:

> +static int hyperv_conn_init(struct hyperv_drm_device *hv)
> +{
> +=09drm_connector_helper_add(&hv->connector, &hyperv_connector_helper_fun=
cs);
> +=09return drm_connector_init(&hv->dev, &hv->connector,
> +=09=09=09=09  &hyperv_connector_funcs,
> +=09=09=09=09  DRM_MODE_CONNECTOR_VGA);
> +}

Nit: shouldn't this be DRM_MODE_CONNECTOR_Virtual?
