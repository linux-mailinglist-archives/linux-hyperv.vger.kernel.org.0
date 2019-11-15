Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863A7FD7E3
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Nov 2019 09:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfKOI02 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 15 Nov 2019 03:26:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20672 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727116AbfKOI0X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 15 Nov 2019 03:26:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573806381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xt7ctRiywIG1tpU0cT26zCBUdn9q3E2Aseumqp8v+zU=;
        b=e9lHlgRWsugelA1gTvRfjNDi97koBCuKCS7h6udcuchMc2hT3n4TRgmeXI6p2JKgWUp1Y1
        k2lPeQzuOUfYTE9eFF+d0iflnZOljJKjQ6ninjUugw8o4Bi7lyGUnOb6Rzj4Ecme8uRCBI
        Gp4KmKKkqQ1sBV7wCuy4nNye4hvAxaQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-Qjy3UQTCPi6CNika2vS85A-1; Fri, 15 Nov 2019 03:26:20 -0500
Received: by mail-wr1-f72.google.com with SMTP id e3so7233850wrs.17
        for <linux-hyperv@vger.kernel.org>; Fri, 15 Nov 2019 00:26:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RoXy81G7M/BfnHRZ4y2U2/JU3z4ekC5J7eZ1fYMw4CI=;
        b=IumQLxqAlgX6tbORcdZ0CaihVifLU0r971sPhwUWwQnBPkJbzUtIQmWOuyt5HWuwYI
         FkAmqc0XW+PQ8i4kje77O0z5wrs48vpaV3W/79GFKjX0g5T2mxzIb7aDuOgoG/uo0KOB
         /nXfnic+SyHvIjqnfOTFKsyrT2CdKOdR4oQhH6BC0sWfnanySB6sAU3+2XTIgYJi3nih
         9XlhdhGoYQ5vUysdcW3RokjC0ggeywZAsS9n53vkbW1vl5CNG4bx073KGzlcloeRQcnY
         vzVyDdZn0m+70SOmjvE956wV2qHilTxQrO1HDAITdzJ1rackTgM21x4Ksf/Xl/EC7Aqv
         CZ3w==
X-Gm-Message-State: APjAAAXgeD1S8oarLw7TqOmMWa19aHyJLcLwyNx4y3y/9koEPOr/NaQp
        mq7LTmI4A64CWTT6KXnK81uv2SCWaL0h+ynz1vF1oVV9E3dcMeqS96cSLV4tzJrqrjC3WG5pTna
        AvCVus9/cDOIhRtF84vki9jzT
X-Received: by 2002:adf:f78c:: with SMTP id q12mr13056402wrp.71.1573806379269;
        Fri, 15 Nov 2019 00:26:19 -0800 (PST)
X-Google-Smtp-Source: APXvYqyvFtcZcCmdybEhREmfVJhjMJWYu5vgKjT2yNfXmAdZcdboUyo4lpokec2THBO5n/9IFhwgFw==
X-Received: by 2002:adf:f78c:: with SMTP id q12mr13056369wrp.71.1573806378928;
        Fri, 15 Nov 2019 00:26:18 -0800 (PST)
Received: from steredhat (a-nu5-32.tin.it. [212.216.181.31])
        by smtp.gmail.com with ESMTPSA id 19sm12549850wrc.47.2019.11.15.00.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2019 00:26:18 -0800 (PST)
Date:   Fri, 15 Nov 2019 09:26:15 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, sthemmin@microsoft.com, arnd@arndb.de,
        jhansen@vmware.com, jasowang@redhat.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        mst@redhat.com, haiyangz@microsoft.com, stefanha@redhat.com,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        sashal@kernel.org, kys@microsoft.com, decui@microsoft.com,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH net-next v2 00/15] vsock: add multi-transports support
Message-ID: <20191115082615.uouzvisaz27xny4e@steredhat>
References: <20191114095750.59106-1-sgarzare@redhat.com>
 <20191114.181251.451070581625618487.davem@davemloft.net>
MIME-Version: 1.0
In-Reply-To: <20191114.181251.451070581625618487.davem@davemloft.net>
X-MC-Unique: Qjy3UQTCPi6CNika2vS85A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 14, 2019 at 06:12:51PM -0800, David Miller wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> Date: Thu, 14 Nov 2019 10:57:35 +0100
>=20
> > Most of the patches are reviewed by Dexuan, Stefan, and Jorgen.
> > The following patches need reviews:
> > - [11/15] vsock: add multi-transports support
> > - [12/15] vsock/vmci: register vmci_transport only when VMCI guest/host
> >           are active
> > - [15/15] vhost/vsock: refuse CID assigned to the guest->host transport
> >=20
> > RFC: https://patchwork.ozlabs.org/cover/1168442/
> > v1: https://patchwork.ozlabs.org/cover/1181986/
>=20
> I'm applying this as-is, if there is feedback changes required on 11,
> 12, and 15 please deal with this using follow-up patches.

Thank you very much,
Stefano

