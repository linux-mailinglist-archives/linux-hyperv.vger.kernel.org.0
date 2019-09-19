Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC1B776C
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Sep 2019 12:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731889AbfISK1w (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Sep 2019 06:27:52 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34277 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730905AbfISK1w (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Sep 2019 06:27:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568888870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ig1366euhZE9FQ+BU/G4FDeDExCD+2QP6kSKN1WGaNY=;
        b=Klfemz4hmAs9HYuZxZoxwuKlqtPzLnGojJc+lTi7gMEMNYNHiwFBFjZch+cIrp2pHvEyqP
        Ag8AtowPyiWQIBMpyKFH2bhyww6c0YbWOcF/y2jRgrlp5PQLvJ8cG2Yv73jA8ohvoKQXuN
        Dig6WBnKkFAcKOkbl/t2KG0tbPPpRAA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-TlDU4mDhPH6BK6WpC_i7Tw-1; Thu, 19 Sep 2019 06:27:42 -0400
Received: by mail-wr1-f70.google.com with SMTP id j2so864311wre.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Sep 2019 03:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xXbMAImjG3OUwHMb6kPmWON5bGyQvvmz+1UruhCN6yE=;
        b=cH20H+J7fWBQPSbhgD6Xf6uJEPpYRxPFr4iQqlF+rVIXjWhPh7hRHTP1bWcNkIeFjM
         7eWpCPv7EJA14kOVCYLs5+248l4CFiSLeJeRGDlzKUJi4rN99PF998KTGaJ+zkDKtI6c
         v9hMGnGf9s2vbxLTVKtG8n+UlWC/9BZFtg5/8f4LeSWlPrX+sqV7oGSz4ypWOMYlCw/M
         YVWgGYyrlRJ9mnwqNyywicnuIvEmgdK6+HVJBw7ywDsLrLBg0NsJQaxZ5A647JkVhEjf
         Chxa/JSxOJzs4OAatDTvT0Pc8fl2RhlUIK/X8nuZuiih6ZRsizMeRfrHeHa424f+sbsj
         0bJA==
X-Gm-Message-State: APjAAAX/nwT0PXwuofIOIF5yBG4/DEmvRKiU9DwFyq3Lut4BDwGiC7lg
        gVTdzoZfBGBZRDaNZo24mb87ZRBwa+C4XjijQdCcbrcogDSs9Vm3pQI8CPSjWzVB6KKMK2xuxKK
        fD1+D0fvtd0qJhdd7TWThDMcO
X-Received: by 2002:a5d:4f8c:: with SMTP id d12mr6688935wru.150.1568888861515;
        Thu, 19 Sep 2019 03:27:41 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz46e8anRMP1kp0PhuFgPO+/GbU0XjcEmMYDIh9szRAuk4BfIfrefzg5JHBBewFOt1LeJvGiQ==
X-Received: by 2002:a5d:4f8c:: with SMTP id d12mr6688918wru.150.1568888861290;
        Thu, 19 Sep 2019 03:27:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 17sm8806368wrl.15.2019.09.19.03.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 03:27:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>
Subject: RE: [PATCH 1/3] hv_utils: Add the support of hibernation
In-Reply-To: <PU1P153MB01694ABFED7ADAE8B40A65F7BF890@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
References: <1568245130-70712-1-git-send-email-decui@microsoft.com> <1568245130-70712-2-git-send-email-decui@microsoft.com> <877e6dcvzj.fsf@vitty.brq.redhat.com> <PU1P153MB0169C6B4A78787930CC9ED4FBFB30@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM> <87pnk0bpe8.fsf@vitty.brq.redhat.com> <PU1P153MB01694ABFED7ADAE8B40A65F7BF890@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Date:   Thu, 19 Sep 2019 12:27:39 +0200
Message-ID: <87ftksa8dg.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: TlDU4mDhPH6BK6WpC_i7Tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Dexuan Cui <decui@microsoft.com> writes:

> BTW, for vss, maybe the VM should not hibernate if there is a backup=20
> ongoing? -- if the file system is frozen by hv_vss_daemon, and the VM
> hibernates, then when the VM resumes back, it's almost always true that=
=20
> the VM won't receive the host's VSS_OP_THAW request, and the VM will
> end up in an unusable state.

Makes sense. Or, alternatively, can we postpone hibernation until after
VSS_OP_THAW?

--=20
Vitaly

